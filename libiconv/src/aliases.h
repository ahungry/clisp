/* ANSI-C code produced by gperf version 2.7 */
/* Command-line: gperf -t -L ANSI-C -H aliases_hash -N aliases_lookup -7 -C -k 1,3-11,$ src/aliases.gperf  */
struct alias { const char* name; unsigned int encoding_index; };

#define TOTAL_KEYWORDS 293
#define MIN_WORD_LENGTH 2
#define MAX_WORD_LENGTH 45
#define MIN_HASH_VALUE 4
#define MAX_HASH_VALUE 2362
/* maximum key range = 2359, duplicates = 0 */

#ifdef __GNUC__
__inline
#endif
static unsigned int
aliases_hash (register const char *str, register unsigned int len)
{
  static const unsigned short asso_values[] =
    {
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363,    0,   15, 2363,   45,  230,
        75,  460,  510,   25,   35,  455,    0,  115,  160, 2363,
      2363, 2363, 2363, 2363, 2363,  406,  115,  290,  200,    0,
        65,  295,  100,    0,    5,  358,   40,   60,   15,    0,
        10, 2363,   60,    0,    0,  180,   40,    0,   90,   10,
         0, 2363, 2363, 2363, 2363,  340, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363,
      2363, 2363, 2363, 2363, 2363, 2363, 2363, 2363
    };
  register int hval = len;

  switch (hval)
    {
      default:
      case 11:
        hval += asso_values[(unsigned char) str[10]];
      case 10:
        hval += asso_values[(unsigned char) str[9]];
      case 9:
        hval += asso_values[(unsigned char) str[8]];
      case 8:
        hval += asso_values[(unsigned char) str[7]];
      case 7:
        hval += asso_values[(unsigned char) str[6]];
      case 6:
        hval += asso_values[(unsigned char) str[5]];
      case 5:
        hval += asso_values[(unsigned char) str[4]];
      case 4:
        hval += asso_values[(unsigned char) str[3]];
      case 3:
        hval += asso_values[(unsigned char) str[2]];
      case 2:
      case 1:
        hval += asso_values[(unsigned char) str[0]];
        break;
    }
  return hval + asso_values[(unsigned char) str[len - 1]];
}

#ifdef __GNUC__
__inline
#endif
const struct alias *
aliases_lookup (register const char *str, register unsigned int len)
{
  static const struct alias wordlist[] =
    {
      {""}, {""}, {""}, {""},
      {"SJIS", ei_sjis},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"JP", ei_iso646_jp},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"L8", ei_iso8859_14},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"LATIN8", ei_iso8859_14},
      {"R8", ei_hp_roman8},
      {""}, {""},
      {"MS-EE", ei_cp1250},
      {""},
      {"L5", ei_iso8859_9},
      {""}, {""}, {""}, {""}, {""},
      {"866", ei_cp866},
      {"TCVN", ei_tcvn},
      {""}, {""},
      {"L6", ei_iso8859_10},
      {""},
      {"SHIFT-JIS", ei_sjis},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"850", ei_cp850},
      {"ISO-IR-58", ei_gb2312},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"HZ", ei_hz},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"LATIN5", ei_iso8859_9},
      {""}, {""}, {""}, {""}, {""},
      {"L2", ei_iso8859_2},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"LATIN6", ei_iso8859_10},
      {""},
      {"NEXTSTEP", ei_nextstep},
      {""}, {""}, {""}, {""},
      {"ISO-IR-6", ei_ascii},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"ISO-8859-8", ei_iso8859_8},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"IBM866", ei_cp866},
      {""}, {""}, {""}, {""}, {""},
      {"JIS0208", ei_jisx0208},
      {""}, {""}, {""},
      {"IBM850", ei_cp850},
      {"US", ei_ascii},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-8859-5", ei_iso8859_5},
      {""}, {""}, {""}, {""}, {""},
      {"TIS620", ei_tis620},
      {"TIS-620", ei_tis620},
      {""}, {""}, {""},
      {"LATIN2", ei_iso8859_2},
      {""}, {""}, {""},
      {"X0208", ei_jisx0208},
      {""}, {""}, {""}, {""},
      {"ISO-8859-6", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"UTF-8", ei_utf8},
      {""}, {""},
      {"TIS620-0", ei_tis620},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"L1", ei_iso8859_1},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"HEBREW", ei_iso8859_8},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-226", ei_iso8859_16},
      {""}, {""}, {""}, {""},
      {"EUCTW", ei_euc_tw},
      {"EUC-TW", ei_euc_tw},
      {""}, {""}, {""},
      {"ISO-8859-2", ei_iso8859_2},
      {""}, {""},
      {"UCS-2-LE", ei_ucs2le},
      {""}, {""},
      {"ISO-2022-JP", ei_iso2022_jp},
      {"CN", ei_iso646_cn},
      {""}, {""}, {""}, {""},
      {"CHINESE", ei_gb2312},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"EUCJP", ei_euc_jp},
      {"EUC-JP", ei_euc_jp},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"UCS-2", ei_ucs2},
      {"VISCII", ei_viscii},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-2022-JP-2", ei_iso2022_jp2},
      {""}, {""}, {""}, {""},
      {"UCS-2-BE", ei_ucs2be},
      {""},
      {"ISO-8859-9", ei_iso8859_9},
      {""}, {""}, {""},
      {"UCS-2-INTERNAL", ei_ucs2internal},
      {"ISO-IR-165", ei_isoir165},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
      {"CP866", ei_cp866},
      {""},
      {"MS-HEBR", ei_cp1255},
      {""}, {""},
      {"ISO-IR-166", ei_tis620},
      {""}, {""}, {""}, {""},
      {"CP850", ei_cp850},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"SHIFT_JIS", ei_sjis},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"ISO-8859-15", ei_iso8859_15},
      {""}, {""}, {""},
      {"ISO-IR-100", ei_iso8859_1},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-126", ei_iso8859_7},
      {""}, {""}, {""}, {""}, {""},
      {"ISO-8859-16", ei_iso8859_16},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"BIG5", ei_ces_big5},
      {"BIG-5", ei_ces_big5},
      {""}, {""}, {""}, {""},
      {"CSSHIFTJIS", ei_sjis},
      {"ISO-8859-10", ei_iso8859_10},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"KOI8-R", ei_koi8_r},
      {""}, {""}, {""},
      {"MS-ANSI", ei_cp1252},
      {""},
      {"ISO_8859-8", ei_iso8859_8},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"L7", ei_iso8859_13},
      {""}, {""}, {""}, {""},
      {"L3", ei_iso8859_3},
      {""}, {""}, {""}, {""},
      {"MS-CYRL", ei_cp1251},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"LATIN1", ei_iso8859_1},
      {"BIGFIVE", ei_ces_big5},
      {"BIG-FIVE", ei_ces_big5},
      {""},
      {"CP950", ei_cp950},
      {"IBM819", ei_iso8859_1},
      {""},
      {"ISO-2022-JP-1", ei_iso2022_jp1},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ELOT_928", ei_iso8859_7},
      {""},
      {"ISO_8859-5", ei_iso8859_5},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"ROMAN8", ei_hp_roman8},
      {""}, {""},
      {"X0212", ei_jisx0212},
      {"UTF-16", ei_utf16},
      {"L4", ei_iso8859_4},
      {""}, {""},
      {"ISO-IR-159", ei_jisx0212},
      {""},
      {"WINDOWS-1258", ei_cp1258},
      {"UTF-16LE", ei_utf16le},
      {""},
      {"ISO_8859-6", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"MACINTOSH", ei_mac_roman},
      {"ISO-IR-109", ei_iso8859_3},
      {""}, {""},
      {"CSIBM866", ei_cp866},
      {""}, {""}, {""},
      {"WINDOWS-1255", ei_cp1255},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-2022-CN-EXT", ei_iso2022_cn_ext},
      {""},
      {"WINDOWS-1256", ei_cp1256},
      {""}, {""}, {""},
      {"CSISO2022JP", ei_iso2022_jp},
      {""}, {""}, {""}, {""},
      {"ISO-2022-CN", ei_iso2022_cn},
      {"WINDOWS-1250", ei_cp1250},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"JIS_X0208", ei_jisx0208},
      {"ISO-8859-1", ei_iso8859_1},
      {""}, {""}, {""},
      {"ISO646-JP", ei_iso646_jp},
      {"EUCCN", ei_euc_cn},
      {"EUC-CN", ei_euc_cn},
      {""}, {""}, {""},
      {"ISO-IR-110", ei_iso8859_4},
      {""}, {""}, {""}, {""}, {""},
      {"CP1258", ei_cp1258},
      {""},
      {"CSVISCII", ei_viscii},
      {""}, {""}, {""},
      {"WINDOWS-1252", ei_cp1252},
      {"UTF-16BE", ei_utf16be},
      {"MACHEBREW", ei_mac_hebrew},
      {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-2", ei_iso8859_2},
      {""}, {""},
      {"MAC", ei_mac_roman},
      {""},
      {"ISO-IR-199", ei_iso8859_14},
      {""}, {""}, {""}, {""},
      {"HP-ROMAN8", ei_hp_roman8},
      {""}, {""}, {""}, {""},
      {"ISO_8859-8:1988", ei_iso8859_8},
      {""}, {""}, {""},
      {"GREEK8", ei_iso8859_7},
      {""}, {""},
      {"CSISO2022JP2", ei_iso2022_jp2},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"X0201", ei_jisx0201},
      {"CP1255", ei_cp1255},
      {""}, {""}, {""},
      {"ISO_8859-5:1988", ei_iso8859_5},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"CP1256", ei_cp1256},
      {""}, {""}, {""}, {""},
      {"ASCII", ei_ascii},
      {""},
      {"TIS620.2529-1", ei_tis620},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"CP1250", ei_cp1250},
      {""}, {""}, {""},
      {"ISO_8859-9", ei_iso8859_9},
      {""}, {""},
      {"UNICODELITTLE", ei_ucs2le},
      {"KOI8-U", ei_koi8_u},
      {""}, {""}, {""}, {""}, {""},
      {"CSISO159JISX02121990", ei_jisx0212},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"UCS-4-LE", ei_ucs4le},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"JOHAB", ei_johab},
      {""}, {""}, {""}, {""},
      {"ISO_8859-15:1998", ei_iso8859_15},
      {""}, {""}, {""},
      {"CP819", ei_iso8859_1},
      {"CSBIG5", ei_ces_big5},
      {"CN-BIG5", ei_ces_big5},
      {""},
      {"ISO-2022-KR", ei_iso2022_kr},
      {"ISO-IR-138", ei_iso8859_8},
      {""}, {""},
      {"UHC", ei_cp949},
      {""},
      {"ARMSCII-8", ei_armscii_8},
      {"WINBALTRIM", ei_cp1257},
      {"CSEUCTW", ei_euc_tw},
      {""},
      {"ISO646-US", ei_ascii},
      {""},
      {"ISO_8859-15", ei_iso8859_15},
      {""},
      {"EUCKR", ei_euc_kr},
      {"EUC-KR", ei_euc_kr},
      {"CSKOI8R", ei_koi8_r},
      {"CP1252", ei_cp1252},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"KOI8-RU", ei_koi8_ru},
      {""},
      {"WINDOWS-1251", ei_cp1251},
      {""}, {""}, {""},
      {"ISO_8859-16", ei_iso8859_16},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CN-GB-ISOIR165", ei_isoir165},
      {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-101", ei_iso8859_2},
      {"ISO_8859-16:2000", ei_iso8859_16},
      {""}, {""}, {""},
      {"ISO-IR-148", ei_iso8859_9},
      {"ISO_8859-10", ei_iso8859_10},
      {"CSISOLATIN5", ei_iso8859_9},
      {"UCS-4-BE", ei_ucs4be},
      {""}, {""}, {""}, {""}, {""},
      {"UCS-4-INTERNAL", ei_ucs4internal},
      {"CN-GB", ei_euc_cn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSISOLATIN6", ei_iso8859_10},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"ISO_8859-10:1992", ei_iso8859_10},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSISO87JISX0208", ei_jisx0208},
      {""}, {""}, {""}, {""},
      {"KOREAN", ei_ksc5601},
      {"JAVA", ei_java},
      {""},
      {"MACTHAI", ei_mac_thai},
      {""}, {""}, {""},
      {"CSISOLATINHEBREW", ei_iso8859_8},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"JISX0201-1976", ei_jisx0201},
      {"US-ASCII", ei_ascii},
      {"ISO_8859-9:1989", ei_iso8859_9},
      {""}, {""}, {""},
      {"JIS_X0208-1990", ei_jisx0208},
      {""},
      {"CSISO2022CN", ei_iso2022_cn},
      {""}, {""},
      {"UCS-2-SWAPPED", ei_ucs2swapped},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
      {"ISO646-CN", ei_iso646_cn},
      {""}, {""},
      {"CSISOLATIN2", ei_iso8859_2},
      {""},
      {"MACROMAN", ei_mac_roman},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"TCVN-5712", ei_tcvn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ECMA-118", ei_iso8859_7},
      {""}, {""}, {""}, {""}, {""},
      {"CP936", ei_ces_gbk},
      {""}, {""}, {""},
      {"JIS_X0212", ei_jisx0212},
      {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-1", ei_iso8859_1},
      {"CSHPROMAN8", ei_hp_roman8},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"LATIN7", ei_iso8859_13},
      {""}, {""},
      {"ASMO-708", ei_iso8859_6},
      {""}, {""}, {""}, {""},
      {"ISO-IR-87", ei_jisx0208},
      {""},
      {"LATIN3", ei_iso8859_3},
      {""}, {""},
      {"CSUNICODE", ei_ucs2},
      {"ISO-IR-179", ei_iso8859_13},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSASCII", ei_ascii},
      {""},
      {"EXTENDED_UNIX_CODE_PACKED_FORMAT_FOR_JAPANESE", ei_euc_jp},
      {""}, {""}, {""},
      {"CSPC850MULTILINGUAL", ei_cp850},
      {""}, {""}, {""}, {""},
      {"ISO-IR-57", ei_iso646_cn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"WINDOWS-1257", ei_cp1257},
      {""},
      {"GBK", ei_ces_gbk},
      {"MULELAO-1", ei_mulelao},
      {"GREEK", ei_iso8859_7},
      {"WINDOWS-1253", ei_cp1253},
      {"CYRILLIC", ei_iso8859_5},
      {""},
      {"CP932", ei_cp932},
      {""}, {""},
      {"MS-TURK", ei_cp1254},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-149", ei_ksc5601},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSISO2022KR", ei_iso2022_kr},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"ISO-8859-7", ei_iso8859_7},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"WINDOWS-1254", ei_cp1254},
      {""},
      {"JIS_X0201", ei_jisx0201},
      {"ISO-8859-3", ei_iso8859_3},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"GB_1988-80", ei_iso646_cn},
      {"LATIN4", ei_iso8859_4},
      {""}, {""}, {""}, {""},
      {"CP1251", ei_cp1251},
      {""}, {""}, {""}, {""}, {""},
      {"GEORGIAN-PS", ei_georgian_ps},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-203", ei_iso8859_15},
      {""},
      {"JIS_C6220-1969-RO", ei_iso646_jp},
      {""}, {""},
      {"ISO_8859-3:1988", ei_iso8859_3},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-10646-UCS-2", ei_ucs2},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"MS-GREEK", ei_cp1253},
      {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-6:1987", ei_iso8859_6},
      {""}, {""}, {""},
      {"JIS_X0212-1990", ei_jisx0212},
      {"CP949", ei_cp949},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"MACTURKISH", ei_mac_turkish},
      {""},
      {"UTF-7", ei_utf7},
      {""}, {""}, {""}, {""},
      {"ISO_8859-4:1988", ei_iso8859_4},
      {"JIS_X0212.1990-0", ei_jisx0212},
      {""}, {""},
      {"MS-ARAB", ei_cp1256},
      {"ISO-8859-4", ei_iso8859_4},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"MACCENTRALEUROPE", ei_mac_centraleurope},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-2:1987", ei_iso8859_2},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"MS_KANJI", ei_sjis},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"UCS-4", ei_ucs4},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"GB2312", ei_euc_cn},
      {""}, {""}, {""}, {""}, {""},
      {"CSISOLATIN1", ei_iso8859_1},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"ISO-IR-157", ei_iso8859_10},
      {"ISO_8859-14:1998", ei_iso8859_14},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSEUCKR", ei_euc_kr},
      {""}, {""},
      {"TIS620.2533-0", ei_tis620},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
      {"CSMACINTOSH", ei_mac_roman},
      {""}, {""}, {""},
      {"VISCII1.1-1", ei_viscii},
      {""}, {""}, {""}, {""},
      {"ISO_646.IRV:1991", ei_ascii},
      {""}, {""}, {""},
      {"ISO-IR-127", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-8859-13", ei_iso8859_13},
      {""}, {""},
      {"JIS_X0208-1983", ei_jisx0208},
      {""}, {""}, {""}, {""}, {""},
      {"TCVN5712-1", ei_tcvn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-14", ei_iso646_jp},
      {"CSISO58GB231280", ei_gb2312},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"UCS-4-SWAPPED", ei_ucs4swapped},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"ISO_8859-1:1987", ei_iso8859_1},
      {""},
      {"CSISO14JISC6220RO", ei_iso646_jp},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"CSISOLATINCYRILLIC", ei_iso8859_5},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""},
      {"UNICODE-1-1", ei_ucs2be},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"MACUKRAINE", ei_mac_ukraine},
      {""},
      {"MACCYRILLIC", ei_mac_cyrillic},
      {""}, {""}, {""},
      {"UNICODEBIG", ei_ucs2be},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-7", ei_iso8859_7},
      {"ISO-8859-14", ei_iso8859_14},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-3", ei_iso8859_3},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSISOLATINGREEK", ei_iso8859_7},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"MACGREEK", ei_mac_greek},
      {""}, {""}, {""},
      {"TIS620.2533-1", ei_tis620},
      {""},
      {"HZ-GB-2312", ei_hz},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CSISOLATINARABIC", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"IBM367", ei_ascii},
      {"CSEUCPKDFMTJAPANESE", ei_euc_jp},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CP1361", ei_johab},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"ISO_8859-4", ei_iso8859_4},
      {"MACICELAND", ei_mac_iceland},
      {""},
      {"ARABIC", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"CP1257", ei_cp1257},
      {""},
      {"CSISO57GB1988", ei_iso646_cn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CP1253", ei_cp1253},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"MACCROATIAN", ei_mac_croatian},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-10646-UCS-4", ei_ucs4},
      {"KSC_5601", ei_ksc5601},
      {""}, {""}, {""},
      {"ISO_8859-7:1987", ei_iso8859_7},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"GB_2312-80", ei_gb2312},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"UNICODE-1-1-UTF-7", ei_utf7},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSGB2312", ei_euc_cn},
      {""}, {""},
      {"CSHALFWIDTHKATAKANA", ei_jisx0201},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-13", ei_iso8859_13},
      {""}, {""}, {""}, {""},
      {"CP1254", ei_cp1254},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSUNICODE11", ei_ucs2be},
      {""}, {""}, {""}, {""}, {""},
      {"CSISOLATIN3", ei_iso8859_3},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"CP367", ei_ascii},
      {"WINDOWS-874", ei_cp874},
      {""}, {""}, {""},
      {"TCVN5712-1:1993", ei_tcvn},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"MACROMANIA", ei_mac_romania},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO_8859-14", ei_iso8859_14},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"CP874", ei_cp874},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSISOLATIN4", ei_iso8859_4},
      {""}, {""}, {""},
      {"CSUCS4", ei_ucs4},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"GEORGIAN-ACADEMY", ei_georgian_academy},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ISO-IR-144", ei_iso8859_5},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSUNICODE11UTF7", ei_utf7},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"MACARABIC", ei_mac_arabic},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"ECMA-114", ei_iso8859_6},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"KS_C_5601-1989", ei_ksc5601},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""},
      {"ANSI_X3.4-1968", ei_ascii},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""},
      {"CSKSC56011987", ei_ksc5601},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""},
      {"CP1133", ei_cp1133},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""},
      {"IBM-CP1133", ei_cp1133},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {""}, {""}, {""}, {""}, {""}, {""}, {""},
      {"KS_C_5601-1987", ei_ksc5601}
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = aliases_hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= 0)
        {
          register const char *s = wordlist[key].name;

          if (*str == *s && !strcmp (str + 1, s + 1))
            return &wordlist[key];
        }
    }
  return 0;
}
