# Represents a phone number split into multiple parts:
# * +country_code+ - Uniquely identifiers the country to which the number belongs.
#   This value is based on the E.164 standard (http://en.wikipedia.org/wiki/E.164)
# * +number+ - The subscriber number (10 digits in length)
# * +extension+ - A number that can route to different phones at a location
# 
# This phone number format is biased towards those types found in the United
# States and may need to be adjusted for international support.
class PhoneNumber < ActiveRecord::Base
  # The valid lengths allowed per country code for area code + subscriber number
  VALID_LENGTHS = {
    1 =>  10,     7 => 10,      20 => 9,       27 => 9,      30 => 10,      31 => 9,
    32 => 8..9,   33 => 9..10,  34 => 9,       36 => 8..9,   39 => 9,       40 => 9,
    41 => 9..10,  43 => 7..13,  44 => 10..11,  45 => 8,      46 => 9,       47 => 8,     
    48 => 9,      49 => 7..11,  51 => 8..9,    52 => 8..10,  53 => 8,       54 => 8..9, 
    55 => 10,     56 => 8..9,   57 => 9..10,   58 => 10,     60 => 9..10,   61 => 9,
    62 => 8..11,  63 => 8..10,  64 => 8..9,    65 => 8..9,   66 => 9..10,   81 => 9..10,
    82 => 8..9,   84 => 7..10,  86 => 7..11,   90 => 10,     91 => 10,      92 => 9..10,
    93 => 8..9,   94 => 10,     95 => 7..8,    98 => 10,     212 => 8,      213 => 8,
    216 => 8,     218 => 8..9,  220 => 7,      221 => 7,     222 => 7,      223 => 8,
    224 => 8,     225 => 8,     226 => 8,      227 => 8,     228 => 7,      229 => 8,
    230 => 7,     231 => 6..8,  232 => 8,      233 => 5..8,  234 => 7..8,   235 => 7,
    236 => 8,     237 => 8,     238 => 7,      239 => 6..7,  240 => 6,      241 => 6..8,
    242 => 7,     243 => 8,     244 => 9,      245 => 7,     246 => 4..7,   247 => 4,
    248 => 6,     249 => 9,     250 => 5..8,   251 => 9,     252 => 7..8,   253 => 6,
    254 => 9,     255 => 9,     256 => 9,      257 => 8,     258 => 8..9,   260 => 9,
    261 => 9,     262 => 10,    263 => 8..11,  264 => 6..7,  265 => 8,      266 => 8,
    267 => 7,     268 => 7,     269 => 7,      290 => 4,     291 => 7,      297 => 7,
    298 => 6,     299 => 6,     350 => 8,      351 => 9,     352 => 9,      353 => 9,
    354 => 7..9,  355 => 7..9,  356 => 8,      357 => 8,     358 => 9,      359 => 8..10,
    370 => 8,     371 => 8,     372 => 7..8,   373 => 8,     374 => 8,      375 => 9,
    376 => 6..9,  377 => 8..9,  378 => 9..12,  380 => 8..9,  381 => 9,      382 => 8,
    385 => 8,     386 => 8,     387 => 8,      388 => 8..10, 389 => 7..8,   420 => 9,
    421 => 9,     423 => 7,     500 => 5,      501 => 7,     502 => 8,      503 => 8,
    504 => 7..8,  505 => 8,     506 => 8,      507 => 7,     508 => 6,      509 => 8,
    590 => 10,    591 => 8,     592 => 6..7,   593 => 8..9,  594 => 10,     595 => 9,
    596 => 10,    597 => 6,     598 => 7..8,   599 => 7,     670 => 7,      672 => 6,
    673 => 7,     674 => 7,     675 => 7,      676 => 5..7,  677 => 5,      678 => 5..7,
    679 => 7,     680 => 7,     681 => 6,      682 => 5,     683 => 4,      685 => 6..7,
    686 => 5,     687 => 6,     688 => 5,      689 => 6,     690 => 4,      691 => 7,
    692 => 7,     800 => 8..12, 808 => 8,      850 => 8..9,  852 => 8,      853 => 8,
    855 => 8,     856 => 8,     870 => 9,      871 => 9,     872 => 9,      873 => 9,
    874 => 9,     878 => 9,     880 => 10,     881 => 6,     882 => 6,      883 => 6,
    886 => 7..8,  960 => 7,     961 => 8,      962 => 8..9,  963 => 7..8,   964 => 8..10,
    965 => 7,     966 => 8..9,  967 => 7..9,   968 => 8,     970 => 8,      971 => 7..9,
    972 => 7..9,  973 => 8,     974 => 7,      975 => 7..8,  976 => 7..10,  977 => 7..8,
    979 => 9,     991 => 9,     992 => 9,      993 => 8,     994 => 8..9,   995 => 9,
    996 => 9,     998 => 9
  }.stringify_keys
  
  # The list of country calling codes as defined by ITU-T recommendation E.164
  COUNTRY_CODES = VALID_LENGTHS.keys
  
  # Whether to always use the default country code configured for this model
  # when parsing the raw content of a phone number
  cattr_accessor :use_default_country_code_on_parse
  @@use_default_country_code_on_parse = false
  
  belongs_to :phoneable, :polymorphic => true
  
  validates_presence_of :phoneable_id, :phoneable_type, :country_code, :number
  validates_numericality_of :number
  validates_numericality_of :extension, :allow_nil => true
  validates_length_of :extension, :maximum => 10, :allow_nil => true
  validates_inclusion_of :country_code, :in => COUNTRY_CODES
  validates_each :number do |phone_number, attr, value|
    country_code = phone_number.country_code
    
    if country_code && length = VALID_LENGTHS[country_code]
      if length.is_a?(Range)
        if value.nil? || value.size < length.begin
          phone_number.errors.add(attr, :too_short, :count => length.begin)
        elsif value.size > length.end
          phone_number.errors.add(attr, :too_long, :count => length.end)
        end
      elsif value.nil? || value.size != length
        phone_number.errors.add(attr, :wrong_length, :count => length) 
      end
    end
  end
  
  # The raw, unparsed content containing the phone number.  This can be parsed
  # in various formats, such as:
  # * 599 600 11 22
  # * + 386 1 5853 449
  # * +48 (22) 641 0001
  # * 36 1 267-4636
  # * +39-02-4823001
  # * 202 331 996 x4621
  # * 358 2 141 540 65 ext. 1423
  attr_accessor :content
  before_validation_on_create :parse_content, :if => :content
  
  private
    # Parses the raw content of a phone number, extracting the following
    # attributes:
    # * country_code
    # * number
    # * extension
    def parse_content
      content = self.content.strip
      
      # Check for extension
      if match = content.match(/\s*(?:(?:ext|ex|xt|x)[\s.:]*(\d+))$/i)
        self.extension = match[1]
        content.gsub!(match.to_s, '')
      end
 
      # Remove non-digits and leading 0
      content.gsub!(/\D/, '')
      content.gsub!(/^0+/, '')
      
      if use_default_country_code_on_parse
        # Scrub pre-determined country code
        content.gsub!(/^#{country_code}/, '')
      else
        # Try to figure out the country code.  It is not possible for one
        # country code's number to overlap another.
        (1..3).each do |length|
          code = content[0, length]
          if VALID_LENGTHS[code] # Fast lookup
            self.country_code = code
            content.gsub!(/^#{code}/, '')
            break
          end
        end
      end
      
      self.number = content
    end
end
