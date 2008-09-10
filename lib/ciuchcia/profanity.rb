require 'yaml'

module Ciuchcia

  class Profanity
    
    def self.vulgar_words
      YAML.load_file(File.join(File.expand_path(File.dirname(__FILE__)),'..','..','config','vulgar_words.yml' ))
    end
  
    def self.bad_word?(word)
      vulgar_words.include? word
    end
    
    def self.check(text)
  
      vulgar_words.each do |word|
        nw = '[^A-Za-z0-9]*'
        regexp_string = '(\W|^)'+word.split('').map {|l| "#{l}+"}.join(nw)+'(\W|$)'
        regexp = Regexp.new regexp_string,'i'
        m = text.match regexp
        return m[0].strip if m
      end
      false
    end
    

    end 
  
  end
