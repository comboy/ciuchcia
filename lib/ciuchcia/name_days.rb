require 'yaml'

module Ciuchcia 
  class NameDays
    
    def self.list
      @@name_days = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)),'..','..','config','name_days.yml' ))
    end    
    
    def self.today
      t = Time.now
      list[t.month][t.day]
    end
    
    def self.list_full
      @@name_days = YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)),'..','..','config','name_days_full.yml' ))
    end    

    def self.today_full
      t = Time.now
      list_full[t.month][t.day]
    end

  end
   
end