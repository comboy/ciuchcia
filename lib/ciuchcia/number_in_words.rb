#module Ciuchcia
  #class << self
    
    # Number in words
    # Example usage: 
    #   number_in_words(107) # returns "sto siedem"
    def number_in_words(n,ending=nil)
      # It's probably the worst code in ruby I've ever written
      # It seems to work, but it definitely should not ;)
      return '' if n == 0
      sc = [''] + %w{jeden dwa trzy cztery pięć sześć siedem osiem dziewięć}
      sn = %w{dziesięć jedenaście dwanaście trzynaście czternaście piętnaście szesnaście siedemnaście osiemnaście dziewiętnaście}
      sd = ['',''] + %w{dwadzieścia trzydzieści czterdzieści pięćdziesiąt sześćdziesiąt siedemdziesiąt osiemdziesiąt dziewiędziesiąt sto}
      ss = [''] + %w{sto dwieście trzysta czterysta pięćset sześćset siedemset osiemset dziewięćset}
      b = (ending || ['','','']),%w{tysiąc tysiące tysięcy},%w{milion miliony milionów},%w{miliard miliardy miliarðów}     
      p = n.to_s.size 
      return 'bardzo dużo' if p > 11
      d,dn = n.to_s[0,(p%3 == 0 ? 3 : p%3)], n.to_s[(p%3 == 0 ? 3 : p%3)..-1]
      return "#{d.to_i==0 ? '' : b[((p-1)/3.0).floor][0]} #{number_in_words(dn,ending)}".strip if (d.to_i == 1 or d.to_i == 0 ) and n != 1
      r = ''
      (d.size-1).downto(0) do |i|
        r += ' ' unless r[-1] and r[-1].chr == ' '
        r += ss[d[-i-1].chr.to_i] if i == 2    
        d[-i-1].chr.to_i == 1 ? (r += sn[d[-i].chr.to_i]; d = d[0..-2]; break) : r += sd[d[-i-1].chr.to_i] if i == 1
        r += sc[d[-i-1].chr.to_i] if i == 0    
      end
      (2..4) === (d.to_i % 10) ? k=1 : k=2
      "#{r.strip} #{b[((p-1)/3.0).floor][k]} #{number_in_words(dn.to_i,ending)}".strip
    end

    # Money in words
    # Same as number in words but adds currency name
    #   money_in_words (2.50) # "dwa złote pięćdziesiąt groszy
    def money_in_words(x)
      zl = x.floor; gr = (x*100).round%100; r = ''
      r += number_in_words(zl,['złoty','złote','złotych']) if zl > 0
      r += ' '+number_in_words(gr,['grosz','grosze','groszy']) if gr > 0  
      r           
    end
    
    
  #end
#end