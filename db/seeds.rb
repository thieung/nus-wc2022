require 'csv'

# Generate teams
raw_data_teams = [{"key"=>"alg", "title"=>"Algeria", "code"=>"ALG"},
   {"key"=>"egy", "title"=>"Egypt", "code"=>"EGY"},
   {"key"=>"mar", "title"=>"Morocco", "code"=>"MAR"},
   {"key"=>"lby", "title"=>"Libya", "code"=>"LBY"},
   {"key"=>"tun", "title"=>"Tunisia", "code"=>"TUN"},
   {"key"=>"cpv", "title"=>"Cape Verde", "code"=>"CPV"},
   {"key"=>"gam", "title"=>"Gambia", "code"=>"GAM"},
   {"key"=>"gui", "title"=>"Guinea", "code"=>"GUI"},
   {"key"=>"gnb", "title"=>"Guinea-Bissau", "code"=>"GNB"},
   {"key"=>"lbr", "title"=>"Liberia", "code"=>"LBR"},
   {"key"=>"mli", "title"=>"Mali", "code"=>"MLI"},
   {"key"=>"mtn", "title"=>"Mauritania", "code"=>"MTN"},
   {"key"=>"sen", "title"=>"Senegal", "code"=>"SEN"},
   {"key"=>"sle", "title"=>"Sierra Leone", "code"=>"SLE"},
   {"key"=>"ben", "title"=>"Benin", "code"=>"BEN"},
   {"key"=>"bfa", "title"=>"Burkina Faso", "code"=>"BFA"},
   {"key"=>"civ", "title"=>"Côte d'Ivoire", "code"=>"CIV"},
   {"key"=>"gha", "title"=>"Ghana", "code"=>"GHA"},
   {"key"=>"nig", "title"=>"Niger", "code"=>"NIG"},
   {"key"=>"nga", "title"=>"Nigeria", "code"=>"NGA"},
   {"key"=>"tog", "title"=>"Togo", "code"=>"TOG"},
   {"key"=>"cmr", "title"=>"Cameroon", "code"=>"CMR"},
   {"key"=>"cta", "title"=>"Central African Republic", "code"=>"CTA"},
   {"key"=>"cha", "title"=>"Chad", "code"=>"CHA"},
   {"key"=>"cgo", "title"=>"Congo", "code"=>"CGO"},
   {"key"=>"cod", "title"=>"Congo DR", "code"=>"COD"},
   {"key"=>"eqg", "title"=>"Equatorial Guinea", "code"=>"EQG"},
   {"key"=>"gab", "title"=>"Gabon", "code"=>"GAB"},
   {"key"=>"stp", "title"=>"São Tomé and Príncipe", "code"=>"STP"},
   {"key"=>"bdi", "title"=>"Burundi", "code"=>"BDI"},
   {"key"=>"dji", "title"=>"Djibouti", "code"=>"DJI"},
   {"key"=>"eri", "title"=>"Eritrea", "code"=>"ERI"},
   {"key"=>"eth", "title"=>"Ethiopia", "code"=>"ETH"},
   {"key"=>"ken", "title"=>"Kenya", "code"=>"KEN"},
   {"key"=>"rwa", "title"=>"Rwanda", "code"=>"RWA"},
   {"key"=>"som", "title"=>"Somalia", "code"=>"SOM"},
   {"key"=>"ssd", "title"=>"South Sudan", "code"=>"SSD"},
   {"key"=>"sdn", "title"=>"Sudan", "code"=>"SDN"},
   {"key"=>"tan", "title"=>"Tanzania", "code"=>"TAN"},
   {"key"=>"uga", "title"=>"Uganda", "code"=>"UGA"},
   {"key"=>"zan", "title"=>"Zanzibar", "code"=>"ZAN"},
   {"key"=>"ang", "title"=>"Angola", "code"=>"ANG"},
   {"key"=>"bot", "title"=>"Botswana", "code"=>"BOT"},
   {"key"=>"com", "title"=>"Comoros", "code"=>"COM"},
   {"key"=>"les", "title"=>"Lesotho", "code"=>"LES"},
   {"key"=>"mri", "title"=>"Mauritius", "code"=>"MRI"},
   {"key"=>"mad", "title"=>"Madagascar", "code"=>"MAD"},
   {"key"=>"mwi", "title"=>"Malawi", "code"=>"MWI"},
   {"key"=>"moz", "title"=>"Mozambique", "code"=>"MOZ"},
   {"key"=>"nam", "title"=>"Namibia", "code"=>"NAM"},
   {"key"=>"sey", "title"=>"Seychelles", "code"=>"SEY"},
   {"key"=>"rsa", "title"=>"South Africa", "code"=>"RSA"},
   {"key"=>"swz", "title"=>"Swaziland", "code"=>"SWZ"},
   {"key"=>"zam", "title"=>"Zambia", "code"=>"ZAM"},
   {"key"=>"zim", "title"=>"Zimbabwe", "code"=>"ZIM"},
   {"key"=>"reu", "title"=>"Réunion", "code"=>"REU"},
   {"key"=>"kaz", "title"=>"Kazakhstan", "code"=>"KAZ"},
   {"key"=>"afg", "title"=>"Afghanistan", "code"=>"AFG"},
   {"key"=>"ban", "title"=>"Bangladesh", "code"=>"BAN"},
   {"key"=>"bhu", "title"=>"Bhutan", "code"=>"BHU"},
   {"key"=>"ind", "title"=>"India", "code"=>"IND"},
   {"key"=>"kgz", "title"=>"Kyrgyzstan", "code"=>"KGZ"},
   {"key"=>"mdv", "title"=>"Maldives", "code"=>"MDV"},
   {"key"=>"nep", "title"=>"Nepal", "code"=>"NEP"},
   {"key"=>"pak", "title"=>"Pakistan", "code"=>"PAK"},
   {"key"=>"sri", "title"=>"Sri Lanka", "code"=>"SRI"},
   {"key"=>"tjk", "title"=>"Tajikistan", "code"=>"TJK"},
   {"key"=>"tkm", "title"=>"Turkmenistan", "code"=>"TKM"},
   {"key"=>"uzb", "title"=>"Uzbekistan", "code"=>"UZB"},
   {"key"=>"chn", "title"=>"China", "code"=>"CHN"},
   {"key"=>"hkg", "title"=>"Hong Kong", "code"=>"HKG"},
   {"key"=>"jpn", "title"=>"Japan", "code"=>"JPN"},
   {"key"=>"prk", "title"=>"North Korea", "code"=>"PRK"},
   {"key"=>"kor", "title"=>"South Korea", "code"=>"KOR"},
   {"key"=>"mac", "title"=>"Macau", "code"=>"MAC"},
   {"key"=>"mgl", "title"=>"Mongolia", "code"=>"MGL"},
   {"key"=>"tpe", "title"=>"Taiwan", "code"=>"TPE"},
   {"key"=>"bru", "title"=>"Brunei", "code"=>"BRU"},
   {"key"=>"cam", "title"=>"Cambodia", "code"=>"CAM"},
   {"key"=>"idn", "title"=>"Indonesia", "code"=>"IDN"},
   {"key"=>"lao", "title"=>"Laos", "code"=>"LAO"},
   {"key"=>"mas", "title"=>"Malaysia", "code"=>"MAS"},
   {"key"=>"mya", "title"=>"Myanmar", "code"=>"MYA"},
   {"key"=>"phi", "title"=>"Philippines", "code"=>"PHI"},
   {"key"=>"sin", "title"=>"Singapore", "code"=>"SIN"},
   {"key"=>"tha", "title"=>"Thailand", "code"=>"THA"},
   {"key"=>"tls", "title"=>"Timor-Leste", "code"=>"TLS"},
   {"key"=>"vie", "title"=>"Vietnam", "code"=>"VIE"},
   {"key"=>"aia", "title"=>"Anguilla", "code"=>"AIA"},
   {"key"=>"atg", "title"=>"Antigua and Barbuda", "code"=>"ATG"},
   {"key"=>"abw", "title"=>"Aruba", "code"=>"ABW"},
   {"key"=>"bah", "title"=>"Bahamas", "code"=>"BAH"},
   {"key"=>"brb", "title"=>"Barbados", "code"=>"BRB"},
   {"key"=>"bmu", "title"=>"Bermuda", "code"=>"BMU"},
   {"key"=>"vgb", "title"=>"British Virgin Islands", "code"=>"VGB"},
   {"key"=>"cym", "title"=>"Cayman Islands", "code"=>"CYM"},
   {"key"=>"cub", "title"=>"Cuba", "code"=>"CUB"},
   {"key"=>"cuw", "title"=>"Curaçao", "code"=>"CUW"},
   {"key"=>"dma", "title"=>"Dominica", "code"=>"DMA"},
   {"key"=>"dom", "title"=>"Dominican Republic", "code"=>"DOM"},
   {"key"=>"grn", "title"=>"Grenada", "code"=>"GRN"},
   {"key"=>"hai", "title"=>"Haiti", "code"=>"HAI"},
   {"key"=>"jam", "title"=>"Jamaica", "code"=>"JAM"},
   {"key"=>"msr", "title"=>"Montserrat", "code"=>"MSR"},
   {"key"=>"pur", "title"=>"Puerto Rico", "code"=>"PUR"},
   {"key"=>"skn", "title"=>"Saint Kitts and Nevis", "code"=>"SKN"},
   {"key"=>"lca", "title"=>"Saint Lucia", "code"=>"LCA"},
   {"key"=>"vin", "title"=>"Saint Vincent and the Grenadines", "code"=>"VIN"},
   {"key"=>"tri", "title"=>"Trinidad and Tobago", "code"=>"TRI"},
   {"key"=>"tca", "title"=>"Turks and Caicos Islands", "code"=>"TCA"},
   {"key"=>"vir", "title"=>"United States Virgin Islands", "code"=>"VIR"},
   {"key"=>"bon", "title"=>"Bonaire", "code"=>"BON"},
   {"key"=>"gpe", "title"=>"Guadeloupe", "code"=>"GPE"},
   {"key"=>"mtq", "title"=>"Martinique", "code"=>"MTQ"},
   {"key"=>"maf", "title"=>"Saint Martin", "code"=>"MAF"},
   {"key"=>"sxm", "title"=>"Sint Maarten", "code"=>"SXM"},
   {"key"=>"hon", "title"=>"Honduras", "code"=>"HON"},
   {"key"=>"crc", "title"=>"Costa Rica", "code"=>"CRC"},
   {"key"=>"slv", "title"=>"El Salvador", "code"=>"SLV"},
   {"key"=>"pan", "title"=>"Panama", "code"=>"PAN"},
   {"key"=>"gua", "title"=>"Guatemala", "code"=>"GUA"},
   {"key"=>"blz", "title"=>"Belize", "code"=>"BLZ"},
   {"key"=>"nca", "title"=>"Nicaragua", "code"=>"NCA"},
   {"key"=>"aut", "title"=>"Austria", "code"=>"AUT"},
   {"key"=>"bel", "title"=>"Belgium", "code"=>"BEL"},
   {"key"=>"cyp", "title"=>"Cyprus", "code"=>"CYP"},
   {"key"=>"ger", "title"=>"Germany", "code"=>"GER"},
   {"key"=>"est", "title"=>"Estonia", "code"=>"EST"},
   {"key"=>"esp", "title"=>"Spain", "code"=>"ESP"},
   {"key"=>"fin", "title"=>"Finland", "code"=>"FIN"},
   {"key"=>"fra", "title"=>"France", "code"=>"FRA"},
   {"key"=>"gre", "title"=>"Greece", "code"=>"GRE"},
   {"key"=>"irl", "title"=>"Ireland", "code"=>"IRL"},
   {"key"=>"ita", "title"=>"Italy", "code"=>"ITA"},
   {"key"=>"lux", "title"=>"Luxembourg", "code"=>"LUX"},
   {"key"=>"mlt", "title"=>"Malta", "code"=>"MLT"},
   {"key"=>"ned", "title"=>"Netherlands", "code"=>"NED"},
   {"key"=>"por", "title"=>"Portugal", "code"=>"POR"},
   {"key"=>"svk", "title"=>"Slovakia", "code"=>"SVK"},
   {"key"=>"svn", "title"=>"Slovenia", "code"=>"SVN"},
   {"key"=>"bul", "title"=>"Bulgaria", "code"=>"BUL"},
   {"key"=>"den", "title"=>"Denmark", "code"=>"DEN"},
   {"key"=>"lva", "title"=>"Latvija", "code"=>"LVA"},
   {"key"=>"ltu", "title"=>"Lithuania", "code"=>"LTU"},
   {"key"=>"pol", "title"=>"Poland", "code"=>"POL"},
   {"key"=>"rou", "title"=>"Romania", "code"=>"ROU"},
   {"key"=>"swe", "title"=>"Sweden", "code"=>"SWE"},
   {"key"=>"cze", "title"=>"Czech Republic", "code"=>"CZE"},
   {"key"=>"hun", "title"=>"Hungary", "code"=>"HUN"},
   {"key"=>"and", "title"=>"Andorra", "code"=>"AND"},
   {"key"=>"alb", "title"=>"Albania", "code"=>"ALB"},
   {"key"=>"blr", "title"=>"Belarus", "code"=>"BLR"},
   {"key"=>"sui", "title"=>"Switzerland", "code"=>"SUI"},
   {"key"=>"cro", "title"=>"Croatia", "code"=>"CRO"},
   {"key"=>"srb", "title"=>"Serbia", "code"=>"SRB"},
   {"key"=>"rus", "title"=>"Russia", "code"=>"RUS"},
   {"key"=>"tur", "title"=>"Turkey", "code"=>"TUR"},
   {"key"=>"ukr", "title"=>"Ukraine", "code"=>"UKR"},
   {"key"=>"mkd", "title"=>"Macedonia", "code"=>"MKD"},
   {"key"=>"nor", "title"=>"Norway", "code"=>"NOR"},
   {"key"=>"isl", "title"=>"Iceland", "code"=>"ISL"},
   {"key"=>"bih", "title"=>"Bosnia-Herzegovina", "code"=>"BIH"},
   {"key"=>"lie", "title"=>"Liechtenstein", "code"=>"LIE"},
   {"key"=>"mne", "title"=>"Montenegro", "code"=>"MNE"},
   {"key"=>"mda", "title"=>"Moldova", "code"=>"MDA"},
   {"key"=>"smr", "title"=>"San Marino", "code"=>"SMR"},
   {"key"=>"geo", "title"=>"Georgia", "code"=>"GEO"},
   {"key"=>"arm", "title"=>"Armenia", "code"=>"ARM"},
   {"key"=>"aze", "title"=>"Azerbaijan", "code"=>"AZE"},
   {"key"=>"eng", "title"=>"England", "code"=>"ENG"},
   {"key"=>"sco", "title"=>"Scotland", "code"=>"SCO"},
   {"key"=>"wal", "title"=>"Wales", "code"=>"WAL"},
   {"key"=>"nir", "title"=>"Northern Ireland", "code"=>"NIR"},
   {"key"=>"fro", "title"=>"Faroe Islands", "code"=>"FRO"},
   {"key"=>"gib", "title"=>"Gibraltar", "code"=>"GIB"},
   {"key"=>"isr", "title"=>"Israel", "code"=>"ISR"},
   {"key"=>"bhr", "title"=>"Bahrain", "code"=>"BHR"},
   {"key"=>"irn", "title"=>"Iran", "code"=>"IRN"},
   {"key"=>"irq", "title"=>"Iraq", "code"=>"IRQ"},
   {"key"=>"jor", "title"=>"Jordan", "code"=>"JOR"},
   {"key"=>"kuw", "title"=>"Kuwait", "code"=>"KUW"},
   {"key"=>"lib", "title"=>"Lebanon", "code"=>"LIB"},
   {"key"=>"oma", "title"=>"Oman", "code"=>"OMA"},
   {"key"=>"ple", "title"=>"Palestine", "code"=>"PLE"},
   {"key"=>"qat", "title"=>"Qatar", "code"=>"QAT"},
   {"key"=>"ksa", "title"=>"Saudi Arabia", "code"=>"KSA"},
   {"key"=>"syr", "title"=>"Syria", "code"=>"SYR"},
   {"key"=>"uae", "title"=>"United Arab Emirates", "code"=>"UAE"},
   {"key"=>"yem", "title"=>"Yemen", "code"=>"YEM"},
   {"key"=>"mex", "title"=>"Mexico", "code"=>"MEX"},
   {"key"=>"usa", "title"=>"United States", "code"=>"USA"},
   {"key"=>"can", "title"=>"Canada", "code"=>"CAN"},
   {"key"=>"aus", "title"=>"Australia", "code"=>"AUS"},
   {"key"=>"gum", "title"=>"Guam", "code"=>"GUM"},
   {"key"=>"mnp", "title"=>"Northern Mariana Islands", "code"=>"MNP"},
   {"key"=>"asm", "title"=>"American Samoa", "code"=>"ASM"},
   {"key"=>"cok", "title"=>"Cook Islands", "code"=>"COK"},
   {"key"=>"fij", "title"=>"Fiji", "code"=>"FIJ"},
   {"key"=>"ncl", "title"=>"New Caledonia", "code"=>"NCL"},
   {"key"=>"nzl", "title"=>"New Zealand", "code"=>"NZL"},
   {"key"=>"png", "title"=>"Papua New Guinea", "code"=>"PNG"},
   {"key"=>"sam", "title"=>"Samoa", "code"=>"SAM"},
   {"key"=>"sol", "title"=>"Solomon Islands", "code"=>"SOL"},
   {"key"=>"tah", "title"=>"Tahiti", "code"=>"TAH"},
   {"key"=>"tga", "title"=>"Tonga", "code"=>"TGA"},
   {"key"=>"van", "title"=>"Vanuatu", "code"=>"VAN"},
   {"key"=>"kir", "title"=>"Kiribati", "code"=>"KIR"},
   {"key"=>"niu", "title"=>"Niue", "code"=>"NIU"},
   {"key"=>"tuv", "title"=>"Tuvalu", "code"=>"TUV"},
   {"key"=>"arg", "title"=>"Argentina", "code"=>"ARG"},
   {"key"=>"bra", "title"=>"Brazil", "code"=>"BRA"},
   {"key"=>"chi", "title"=>"Chile", "code"=>"CHI"},
   {"key"=>"par", "title"=>"Paraguay", "code"=>"PAR"},
   {"key"=>"uru", "title"=>"Uruguay", "code"=>"URU"},
   {"key"=>"col", "title"=>"Colombia", "code"=>"COL"},
   {"key"=>"ecu", "title"=>"Ecuador", "code"=>"ECU"},
   {"key"=>"per", "title"=>"Peru", "code"=>"PER"},
   {"key"=>"ven", "title"=>"Venezuela", "code"=>"VEN"},
   {"key"=>"bol", "title"=>"Bolivia", "code"=>"BOL"},
   {"key"=>"guy", "title"=>"Guyana", "code"=>"GUY"},
   {"key"=>"sur", "title"=>"Suriname", "code"=>"SUR"},
   {"key"=>"gyf", "title"=>"French Guiana", "code"=>"GYF"}]
raw_data_teams.each do |attribute|
  Team.create(attribute)
end
csv_teams_raw = File.read("#{Rails.root}/db/data/wc2022/teams.csv")
# Header: key,title_vi
csv_teams = CSV.parse(csv_teams_raw, headers: true)
csv_teams.each do |row|
  team = Team.find_by_key(row['key'])
  team.update_attributes(title_vi: row['title_vi']) if team
end

# Generate groups
raw_data_groups = [
  {"title"=>"Group A", "title_vi" => "Bảng A", "pos"=>1},
  {"title"=>"Group B", "title_vi" => "Bảng B", "pos"=>2},
  {"title"=>"Group C", "title_vi" => "Bảng C", "pos"=>3},
  {"title"=>"Group D", "title_vi" => "Bảng D", "pos"=>4},
  {"title"=>"Group E", "title_vi" => "Bảng E", "pos"=>5},
  {"title"=>"Group F", "title_vi" => "Bảng F", "pos"=>6},
  {"title"=>"Group G", "title_vi" => "Bảng G", "pos"=>7},
  {"title"=>"Group H", "title_vi" => "Bảng H", "pos"=>8},
]
raw_data_groups.each do |attribute|
  Group.create(attribute)
end

# Generate rounds
raw_data_rounds = [
  {"title"=>"Matchday 1", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>1, "start_at"=>"2022-11-20", "end_at"=>"2022-11-20", "money_rate"=>10000},
  {"title"=>"Matchday 2", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>2, "start_at"=>"2022-11-21", "end_at"=>"2022-11-21", "money_rate"=>10000},
  {"title"=>"Matchday 3", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>3, "start_at"=>"2022-11-22", "end_at"=>"2022-11-22", "money_rate"=>10000},
  {"title"=>"Matchday 4", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>4, "start_at"=>"2022-11-23", "end_at"=>"2022-11-23", "money_rate"=>10000},
  {"title"=>"Matchday 5", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>5, "start_at"=>"2022-11-24", "end_at"=>"2022-11-24", "money_rate"=>10000},
  {"title"=>"Matchday 6", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>6, "start_at"=>"2022-11-25", "end_at"=>"2022-11-25", "money_rate"=>10000},
  {"title"=>"Matchday 7", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>7, "start_at"=>"2022-11-26", "end_at"=>"2022-11-18", "money_rate"=>10000},
  {"title"=>"Matchday 8", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>8, "start_at"=>"2022-11-19", "end_at"=>"2022-11-26", "money_rate"=>10000},
  {"title"=>"Matchday 9", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>9, "start_at"=>"2022-11-27", "end_at"=>"2022-11-27", "money_rate"=>10000},
  {"title"=>"Matchday 10", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>10, "start_at"=>"2022-11-28", "end_at"=>"2022-11-28", "money_rate"=>10000},
  {"title"=>"Matchday 11", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>11, "start_at"=>"2022-11-29", "end_at"=>"2022-11-29", "money_rate"=>10000},
  {"title"=>"Matchday 12", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>12, "start_at"=>"2022-11-30", "end_at"=>"2022-11-30", "money_rate"=>10000},
  {"title"=>"Matchday 13", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>13, "start_at"=>"2022-12-01", "end_at"=>"2022-12-01", "money_rate"=>10000},
  {"title"=>"Matchday 14", title_vi: "Vòng bảng", is_group_stage: true, "pos"=>14, "start_at"=>"2022-12-02", "end_at"=>"2022-12-02", "money_rate"=>10000},
  {"title"=>"Round of 16", title_vi: "Vòng 16 đội", is_group_stage: false, "pos"=>15, "start_at"=>"2022-12-03", "end_at"=>"2022-12-07", "money_rate"=>20000},
  {"title"=>"Quarter-finals", title_vi: "Tứ kết", is_group_stage: false, "pos"=>16, "start_at"=>"2022-12-09", "end_at"=>"2022-12-11", "money_rate"=>30000},
  {"title"=>"Semi-finals", title_vi: "Bán kết", is_group_stage: false, "pos"=>17, "start_at"=>"2022-12-14", "end_at"=>"2022-12-15", "money_rate"=>40000},
  {"title"=>"3rd Place", title_vi: "Tranh 3/4", is_group_stage: false, "pos"=>18, "start_at"=>"2022-12-17", "end_at"=>"2022-12-17", "money_rate"=>50000},
  {"title"=>"Final", title_vi: "Chung kết", is_group_stage: false, "pos"=>19, "start_at"=>"2022-12-18", "end_at"=>"2022-12-18", "money_rate"=>50000}
]
raw_data_rounds.each do |attribute|
  Round.create(attribute)
end

# Generate scores
(0..15).each do |i|
  for j in 0..i do
    Score.find_or_create_by(name: "#{i}-#{j}", score1: i, score2: j)
    Score.find_or_create_by(name: "#{j}-#{i}", score1: j, score2: i)
  end
end

# Generate matches/games
csv_matches_raw = File.read("#{Rails.root}/db/data/wc2022/matches.csv")
# Header: pos,play_at,team1_title_vi,team2_title_vi,round_pos,group_pos
csv_matches = CSV.parse(csv_matches_raw, headers: true)
csv_matches.each do |row|
  Game.create(
    pos: row['pos'],
    play_at: DateTime.parse(row['play_at']),
    team1_id: row['team1_title_vi'].present? ? Team.find_by_title_vi(row['team1_title_vi']).try(:id) : nil,
    team2_id: row['team2_title_vi'].present? ? Team.find_by_title_vi(row['team2_title_vi']).try(:id) : nil,
    unknown_team1_title_vi: row['unknown_team1_title_vi'],
    unknown_team2_title_vi: row['unknown_team2_title_vi'],
    round_id: Round.find_by_pos(row['round_pos']).try(:id),
    group_id: Group.find_by_pos(row['group_pos']).try(:id)
  )
end

# Generate investment data for each game/match
Game.order(:id).map(&:id).each do |game_id|
  Investment.find_or_create_by(game_id: game_id)
end

# Generate admin
admin = User.find_by(email: "admin@nustechnology.com")
unless admin
  admin = User.new(
    email: "admin@nustechnology.com",
    username: "admin",
    password: "nus45TGBhu*(",
    password_confirmation: "nus45TGBhu*(",
    full_name: "NUS Technology Company"
  )
  if admin.save
    admin.add_role :boss
  end
end

