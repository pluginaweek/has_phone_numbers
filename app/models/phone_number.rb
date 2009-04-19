# Represents a phone number split into multiple parts:
# * +country_code+ - Uniquely identifiers the country to which the number belongs.
#   This value is based on the E.164 standard (http://en.wikipedia.org/wiki/E.164)
# * +number+ - The subscriber number (10 digits in length)
# * +extension+ - A number that can route to different phones at a location
# 
# This phone number format is biased towards those types found in the United
# States and may need to be adjusted for international support.
class PhoneNumber < ActiveRecord::Base
  # The list of country calling codes as defined by ITU-T recommendation E.164
  COUNTRY_CODES = %w{
    1   7 20 27 30 31 32 33 34 36 39 40 41 43 44 45 46 47 48 49 51 52 53 54 55
    56 57 58 60 61 62 63 64 65 66 81 82 84 86 90 91 92 93 94 95 98  212 213
    216 218 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235
    236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253
    254 255 256 257 258 260 261 262 263 264 265 266 267 268 269 290 291 297
    298 299 350 351 352 353 354 355 356 357 358 359 370 371 372 373 374 375
    376 377 378 379 380 381 382 385 386 387 388 389 420 421 423 500 501 502
    503 504 505 506 507 508 509 590 591 592 593 594 595 596 597 598 599 670
    672 673 674 675 676 677 678 679 680 681 682 683 684 685 686 687 688 689
    690 691 692 800 808 850 852 853 855 856 870 871 872 873 874 878 880 881
    882 883 886 888 960 961 962 963 964 965 966 967 968 970 971 972 973 974
    975 976 977 979 991 992 993 994 995 996 998
  }
  
  belongs_to :phoneable, :polymorphic => true
  
  validates_presence_of :phoneable_id, :phoneable_type, :country_code, :number
  validates_numericality_of :country_code, :number
  validates_numericality_of :extension, :allow_nil => true
  validates_length_of :country_code, :in => 1..3
  validates_length_of :number, :is => 10
  validates_length_of :extension, :maximum => 10, :allow_nil => true
end
