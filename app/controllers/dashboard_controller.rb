class DashboardController < ApplicationController
  require 'yaml'

  def index
    render 'dashboard/index'
  end

  def settings
    @settings = YAML::load_file Rails.root.join('config/config.yml')
  end

  def create
      my_hash = {params[:setting][:key] => params[:setting][:val]}.to_yaml
      puts my_hash
      my_hash = my_hash.gsub('---', '')
      File.open(Rails.root.join('config/config.yml'), 'a+'){ |f| f.write(my_hash) }
      @my_file = settings
      redirect_to :controller => 'dashboard', :action => 'settings'
  end

  def remove
    settings = YAML::load_file Rails.root.join('config/config.yml')
    settings.delete(params[:key])
    File.open(Rails.root.join('config/config.yml'), 'w'){ |f| YAML.dump(settings, f) }
    redirect_to :controller => 'dashboard', :action => 'settings'
  end

end
