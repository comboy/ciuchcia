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
  end
   
end