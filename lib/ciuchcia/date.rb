if Object.const_defined? 'Date'

  class CiuchciaDate < Date
    MONTHNAMES = [nil] + %w{Styczeń Luty Marzec Kwiecień Maj Czerwiec Lipiec Sierpień Wrzesień Październik Listopad Grudzień}
    DAYNAMES = ["Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"]
  end

  # This generates warning, that's definitely bad
  # If you know how to avoid it, please let me know
  Date = CiuchciaDate

end