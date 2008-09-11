require 'yaml'

module Ciuchcia

  class Profanity
    @@data_file = nil
    
    def self.vulgar_words
      YAML.load_file(@@data_file || File.join(File.expand_path(File.dirname(__FILE__)),'..','..','config','vulgar_words.yml' ))
    end

    def self.set_data_file(path)
      @@data_file = path
    end
  
    def self.bad_word?(word)
      vulgar_words.include? word
    end
    
    def self.check(text)      
      # (c) f
      co_za_sraka = $KCODE
      
      $KCODE="NONE"
      
      nw = '[^A-Za-z0-9]'
      utf_letters = "\352\363\261\266\263\277\274\346\361".split('')
      ascii_letters = "eoaslzzcn".split('')
      
      utf_or_ascii = Proc.new do |l|
        if utf_letters.include?(l)
          "(l|#{ascii_letters[utf_letters.index(l)]})"
        elsif l=='o'
          "(o|0)" # o_O
        else
          l
        end
      end
      
      vulgar_words.each do |word|                
        regexp_string = "(#{nw}|^)"+word.split('').map {|l| "#{utf_or_ascii.call l}+"}.join("#{nw}*")+"(#{nw}|$)"
        regexp = Regexp.new regexp_string,'i'
        m = text.match regexp
        $KCODE = co_za_sraka and return m[0].strip if m
      end
      $KCODE = co_za_sraka
      false
    end
    

    end 
  
  end
