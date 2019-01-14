function fuzzy_time --description 'Display the current time as fuzzy time, e.g. "quarter past six".'
	
    set -l hour_str 'twelve' 'one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine' 'ten' 'eleven'
    
    set -l hour    (date '+%H')
    set -l minute  (date '+%M')
#    printf (date '+%a %b %e, ')

    # special cases
    switch $hour:$minute
      case '23:58' '23:59' '00:01' '00:02'
      	printf 'round about midnight'
      	return
      case '12:00'
        printf 'noon '
        return
      case '00:00'
        printf 'midnight '
        return
    end

    
    if test $minute -gt 32
        if test $hour = 23
            set hour  0
        else
            set hour (math $hour+1)
        end
    end
    
    
    set -l m ' pm '

    if test $hour -gt 11
       set hour (math $hour-12)
    else
       set m ' am ' 
    end

    #indexes in fish beguin in 1
    set hour (math $hour+1) 

    set hour $hour_str[$hour]
        
        # rounding to the nearest multiple of 5
    set minute (math 'scale=2;r=(('$minute'/5)+0.5);scale=0;r/1*5') 

    if test $minute = 0 -o $minute = 60
        printf $hour$m"o'clock"
        return
    end
    
    switch $minute
      case 5
        set minute 'five past'
      case 10
        set minute 'ten past'
      case 15
        set minute 'quarter past'
      case 20
        set minute 'twenty past'
      case 25
        set minute 'twenty-five past'
      case 30
        set minute 'half past'
      case 35
        set minute 'twenty-five to'
      case 40
        set minute 'twenty to'
      case 45
        set minute 'quarter to'
      case 50
        set minute 'ten to'
      case 55
        set minute 'five to'
    end
    printf $minute' '$hour$m
end
