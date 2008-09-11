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
    
    def self.valid_pesel?(pesel)
      # validates presence
      return false if pesel.nil? or (pesel.empty? rescue true)
      
      # clean up and check format (should be 11 digits)
      pesel.gsub!(/\ |\-|\../,'')
      return false unless pesel.match(/^\d{11}$/)
      
      weights = [1,3,7,9,1,3,7,9,1,3]
      digits = pesel.split('').map {|i| i.to_i }      
      return false unless digits[0..-2].inject(digits[-1]) { |sum,x| sum + x*weights.shift } % 10 == 0
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
        
        validates_each(attr_names, configuration) do |record, attr_name, value|
          record.errors.add(attr_name, configuration[:message]) unless Ciuchcia::Validations.valid_nip? record.send("#{attr_name}")  
        end          
      end
        
      def validates_regon(*attr_names)
        configuration = { :message => 'Niepoprawny numer REGON', :on => :save }
        configuration.update(attr_names.extract_options!)
                
        validates_each(attr_names, configuration) do |record, attr_name, value|                   
          record.errors.add(attr_name, configuration[:message]) unless Ciuchcia::Validations.valid_regon? record.send("#{attr_name}")       
        end          
      end            

      def validates_pesel(*attr_names)
        configuration = { :message => 'Niepoprawny numer PESEL', :on => :save }
        configuration.update(attr_names.extract_options!)
                
        validates_each(attr_names, configuration) do |record, attr_name, value|                   
          record.errors.add(attr_name, configuration[:message]) unless Ciuchcia::Validations.valid_pesel? record.send("#{attr_name}")       
        end          
      end            
      
      def validates_no_profanity(*attr_names)
        configuration = { :on => :save }
        configuration.update(attr_names.extract_options!)
                
        validates_each(attr_names, configuration) do |record, attr_name, value|                   
          result = Ciuchcia::Profanity.check record.send(attr_name.to_sym)       
          record.errors.add(attr_name, configuration[:message] ? configuration[:message] : "#{result} jest wulgaryzmem") if result 
        end                  
      end
      
      
    end        
  end
end