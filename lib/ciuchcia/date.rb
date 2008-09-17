module Ciuchcia 
  class Date
    MONTHNAMES = [nil] + %w{Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień}
    ABBR_MONTHNAMES = [nil] + %w{Sty Lut Mar Kwi Maj Cze Lip Sie Wrz Paź Lis Gru}
    DAYNAMES = ["Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"]
    ABBR_DAYNAMES = ["Nie", "Pon", "Wto", "Śro", "Czw", "Pią", "Sob"]
  end
end

class Time
  alias :strftime_nolocale :strftime

  def strftime(format)
    format = format.dup
    format.gsub!(/%a/, Ciuchcia::Date::ABBR_DAYNAMES[self.wday])
    format.gsub!(/%A/, Ciuchcia::Date::DAYNAMES[self.wday])
    format.gsub!(/%b/, Ciuchcia::Date::ABBR_MONTHNAMES[self.mon])
    format.gsub!(/%B/, Ciuchcia::Date::MONTHNAMES[self.mon])
    self.strftime_nolocale(format)
  end
end