module Ciuchcia
  class Validations
    
    def self.valid_nip?(nip)
      # validates presence
      return false if nip.nil? or (nip.empty? rescue true)
      
      # format (should be 10 digits)
      nip.gsub!(/\ |\-|\../,'')
      return false unless nip.match(/^\d{10}$/)
      
      # control digit value
      weights = [6,5,7,2,3,4,5,6,7]
      digits = nip.split('').map {|i| i.to_i }
      return false unless digits[-1] == digits[0..-2].inject(0) { |sum,x| sum + x*weights.shift } % 11 % 10
      true
    end
    
    def self.valid_regon?(regon)
      # validates presence
      return false if regon.nil? or (regon.empty? rescue true)
      
      # format (should be 10 digits)
      regon.gsub!(/\ |\-|\../,'')
      
      if regon.size == 14
        # long regon
        long_regon = regon
        regon = regon[0..8]
      end
      return false unless regon.match(/^\d{9}$/)
      
      # control digit value
      weights = [8,9,2,3,4,5,6,7]
      digits = regon.split('').map {|i| i.to_i }
      return false unless digits[-1] == digits[0..-2].inject(0) { |sum,x| sum + x*weights.shift } % 11 % 10
      true
    end
    
  end
end

module ActiveRecord
  class Base
    class << self
      
      def validates_nip(*attr_names)
        configuration = { :message => 'Niepoprawny numer NIP', :on => :save }
        configuration.update(attr_names.extract_options!)
        
        attr_accessor(*(attr_names.map { |n| "#{n}_confirmation" }))
        
        validates_each(attr_names, configuration) do |record, attr_name, value|
          value = record.send("#{attr_name}")          
          record.errors.add(attr_name, configuration[:message]) unless Ciuchcia::Validations.valid_nip? value       
        end          
      end
        
      def validates_regon(*attr_names)
        configuration = { :message => 'Niepoprawny numer REGON', :on => :save }
        configuration.update(attr_names.extract_options!)
        
        attr_accessor(*(attr_names.map { |n| "#{n}_confirmation" }))
        
        validates_each(attr_names, configuration) do |record, attr_name, value|
          value = record.send("#{attr_name}")          
          record.errors.add(attr_name, configuration[:message]) unless Ciuchcia::Validationsvalid_regon? value       
        end          
      end
      
            
    end
    
    
  end
end