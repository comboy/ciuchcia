if Object.const_defined? 'Date'

class CiuchciaDate < Date
  MONTHNAMES = [nil] + %w{Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień}
  Date::DAYNAMES = ["Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"]
end

# This generates warning, that's definitely bad
Date = CiuchciaDate

end