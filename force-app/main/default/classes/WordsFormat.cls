public with sharing class WordsFormat
		{  
      static String[] to_19 = new string[]{ 'Zero', 'One',  'Two', 'Three', 'Four',  'Five',  'Six',  
      'Seven', 'Eight', 'Nine', 'Ten',  'Eleven', 'Twelve', 'Thirteen',  
      'Fourteen', 'Fifteen', 'Sixteen', 'Seventeen', 'Eighteen', 'Nineteen'
        };  
    static String[] tens = new string[]
        { 
            'Twenty', 'Thirty', 'Forty', 'Fifty', 'Sixty', 'Seventy', 'Eighty', 'Ninety'
         };  
    static String[] denom = new string[]
         { 
             '','Thousand',   'Million',     'Billion',    'Trillion',    'Quadrillion',  
              'Quintillion', 'Sextillion',   'Septillion',  'Octillion',   'Nonillion',  
              'Decillion',  'Undecillion',   'Duodecillion', 'Tredecillion',  'Quattuordecillion',  
              'S!xdecillion', 'Septendecillion', 'Octodecillion', 'Novemdecillion', 'Vigintillion'
          };  
    // convert a value < 100  to English.  
    // public decimal WordsFormat {get;set;}
   // public string WordsFormatText {get;set;}
      
   public static String convert_nn(integer val) {  
      if (val < 20)  
        return to_19[val];  
      if(val == 100)  
          return 'One Hundred';  
      for (integer v = 0; v < tens.size(); v++) {  
        String dcap = tens[v];  
        integer dval = 20 + 10 * v;  
        if (dval + 10 > val) {  
          if (Math.Mod(val,10) != 0)  
            return dcap + ' ' + to_19[Math.Mod(val,10)];  
          return dcap;  
        }      
      }  
      return 'Should never get here, less than  failure';  
    }  
    // convert a value <  to english, special cased because it is the level that kicks   
    // off the <  special case. The rest are more general. This also allows you to  
    // get strings in the form of "forty-five hundred" if called directly.  
    public static String convert_nnn(integer val) {  
      String word = '';  
      integer rem = val /100 ;  
      integer mod = Math.mod(val,100);  
      if (rem > 0) {  
        word = to_19[rem] + ' Hundred';  
        if (mod > 0) {  
          word += ' ';  
        }  
      }  
      if (mod >0 ) {  
        word += convert_nn(mod);  
      }  
      return word;  
    }  
    public static String english_number(long val) {  
      if (val < 100) {  
        return convert_nn(val.intValue());  
      }  
      if (val < 1000) {  
        return convert_nnn(val.intValue());  
      }  
      for (integer v = 0; v < denom.size(); v++) {  
        integer didx = v - 1;  
        integer dval = (integer)Math.pow(1000, v);  
        if (dval > val) {  
          integer mod = (integer)Math.pow(1000, didx);  
          integer l = (integer) val / mod;  
          integer r = (integer) val - (l * mod);  
          String ret = convert_nnn(l) + ' ' + denom[didx];  
          if (r > 0) {  
            ret += ' ' + english_number(r);  
          }  
          return ret;  
        }  
      }  
      return 'Should never get here, bottomed out in english_number';  
    }  
  }