# ActiveDirectoryUser (active_directory_user.rb)
# Author       : Ernie Miller
# Last modified: 4/4/2008
#
# Description:
#   A class for authenticating via Active Directory and providing
#   more developer-friendly access to key user attributes through configurable
#   attribute readers.
# 
#   You might find this useful if you want to use a central user/pass from AD
#   but still keep a local DB cache of certain user details for use in foreign
#   key constraints, for instance.
#
# Configuration:
#   Set your server information below, then add attributes you are interested
#   in to the ATTR_SV or ATTR_MV hashes, depending on whether they are single
#   or multi-value attributes. The left hand side is your desired name for
#   the attribute, and the right hand side is the attribute name as it exists
#   in the directory.
#
#   An optional Proc can be supplied to perform some processing on the raw
#   directory data before returning it. This proc should accept a single
#   parameter, the value to be processed. It will be used in Array#collect
#   for multi-value attributes.
#
#   Example:
#     :flanderized_first_name => [ :givenname,
#                                  Proc.new {|n| n + '-diddly'} ]
#
# Usage:
#   user = ActiveDirectoryUser.authenticate('emiller','password')
#   user.first_name # => "Ernie"
#   user.flanderized_first_name # => "Ernie-diddly"
#   user.groups     # => ["Mac Users", "Geeks", "Ruby Coders", ... ]

require 'net/ldap' # gem install ruby-net-ldap

class ActiveDirectoryUser
  ### BEGIN CONFIGURATION ###
  SERVER = 'SynCTSRV03'   # Active Directory server name or IP
  PORT = 389                    # Active Directory server port (default 389)
  BASE = 'DC=synexa,DC=local'    # Base to search from
  DOMAIN = 'SYNEXA'        # For simplified user@domain format login

  # ATTR_SV is for single valued attributes only. Generated readers will
  # convert the value to a string before returning or calling your Proc.
  ATTR_SV = {
      :login => :samaccountname,
      :first_name => :givenname,
      :last_name => :sn,
      :email => :mail
  }


  # ATTR_MV is for multi-valued attributes. Generated readers will always 
  # return an array.
  ATTR_MV = {
      :groups => [ :memberof,
                   # Get the simplified name of first-level groups.
                   Proc.new {|g| g.sub(/.*?CN=(.*?),.*/, '\1')} ]
  }

  # Exposing the raw Net::LDAP::Entry is probably overkill, but could be set
  # up by uncommenting the line below if you disagree.
  #attr_reader :entry

  ### END CONFIGURATION ###

  # Automatically fail login if login or password are empty. Otherwise, try
  # to initialize a Net::LDAP object and call its bind method. If successful,
  # we find the LDAP entry for the user and initialize with it. Returns nil
  # on failure.
  def self.authenticate(login, pass)
    return nil if login.blank? or pass.blank?

    conn = Net::LDAP.new :host => SERVER,
                         :port => PORT,
                         :base => BASE,
                         :auth => { :username => "#{login}@#{DOMAIN}",
                                    :password => pass,
                                    :method => :simple }
    if conn.bind and (user = conn.search(:filter => "sAMAccountName=#{login}").first)
      return self.new(user)
    else
      return nil
    end
      # If we don't rescue this, Net::LDAP is decidedly ungraceful about failing
      # to connect to the server. We'd prefer to say authentication failed.
  rescue Net::LDAP::LdapError => e
    logger.error("Message for the log file #{e.message}")
    return nil
  end

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def member_of?(group)
    self.groups.include?(group)
  end

  def user_groups
    self.groups
  end

  private

  def initialize(entry)
    @entry = entry
    self.class.class_eval do
      generate_single_value_readers
      generate_multi_value_readers
    end
  end

  def self.generate_single_value_readers
    ATTR_SV.each_pair do |k, v|
      val, block = Array(v)
      define_method(k) do
        if @entry.attribute_names.include?(val)
          if block.is_a?(Proc)
            return block[@entry.send(val).to_s.gsub(/[^0-9A-Za-z@.]/, '')]
          else
            return @entry.send(val).to_s.gsub(/[^0-9A-Za-z@.]/, '')
          end
        else
          return ''
        end
      end
    end
  end

  def self.generate_multi_value_readers
    ATTR_MV.each_pair do |k, v|
      val, block = Array(v)
      define_method(k) do
        if @entry.attribute_names.include?(val)
          if block.is_a?(Proc)
            return @entry.send(val).collect(&block)
          else
            return @entry.send(val)
          end
        else
          return []
        end
      end
    end
  end
end