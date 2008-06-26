module ActionView
  module Helpers
    module DateHelper

      def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
        from_time = from_time.to_time if from_time.respond_to?(:to_time)
        to_time = to_time.to_time if to_time.respond_to?(:to_time)
        distance_in_minutes = (((to_time - from_time).abs)/60).round
        distance_in_seconds = ((to_time - from_time).abs).round
        
        def polish_ending(n, endings)          
          case (n % 10)
          when 1: n > 10 ? endings[2] : endings[0]
          when 2..4: endings[1]
          else endings[2]
          end
        end

        case distance_in_minutes
          when 0..1
            return (distance_in_minutes == 0) ? 'mniej niż minuta' : '1 minuta' unless include_seconds
            case distance_in_seconds
              when 0..4   then 'mniej niż 5 sekund'
              when 5..9   then 'mniej niż 10 sekund'
              when 10..19 then 'mniej niż dwadzieścias sekund'
              when 20..39 then 'pół minuty'
              when 40..59 then 'niecała minuta'
              else             '1 minuta'
            end

          when 2..44           then "#{distance_in_minutes} #{polish_ending(distance_in_minutes,['minuta','minuty','minut'])}"
          when 45..89          then 'około godzina'
          when 90..1439        then "około #{(distance_in_minutes.to_f / 60.0).round} #{polish_ending((distance_in_minutes.to_f / 60.0).round,['godzina','godziny','godzin'])}"
          when 1440..2879      then '1 dzień'
          when 2880..43199     then "#{(distance_in_minutes / 1440).round} dni"
          when 43200..86399    then 'około 1 miesiąc'
          when 86400..525599   then "#{(distance_in_minutes / 43200).round} #{polish_ending((distance_in_minutes / 43200).round,['miesiąc','miesiące','miesięcy'])}"
          when 525600..1051199 then 'około rok'
          else                      "ponad #{(distance_in_minutes / 525600).round} #{polish_ending((distance_in_minutes / 525600).round,['rok','lata','lat'])}"
        end
      end
      
      def time_ago_in_words(from_time, include_seconds = false)
        distance_of_time_in_words(from_time, Time.now, include_seconds)
      end

    end
  end
end