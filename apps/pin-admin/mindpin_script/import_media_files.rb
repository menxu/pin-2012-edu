MediaFile.all.blank? || ActiveRecord::Base.connection.execute("TRUNCATE media_files")

if Category.count != 110
  puts '========================================'
  puts '====      preparing categories      ===='
  puts '========================================'

  `rails r mindpin_script/import_categories.rb`

  puts '================ done! ================='
end

creator = User.all.blank? ? User.create(
  :name => 'kaid',
  :password => '1234',
  :password_confirmation => '1234',
  :email => 'kaid@kaid.kaid'
) : User.last

def file_content_type(file_name)
  mime_type = MIME::Types.type_for(file_name)
  mime_type = !mime_type.blank? ?
  mime_type.first.content_type :
  'application/octet-stream'
end


puts '========================================'
puts '====      seeding media_files       ===='
puts '========================================'

file_names_and_sizes = [["1C2A0B9414B8DE88CC4D2612ECB70428_500_708.jpg", 259408], ["Polaris.jpg", 913721], ["wallpaper-1550504.jpg", 621757], ["ny_skyline_by_21giants-d4dv1y9.jpg", 186331], ["Union_by_IvanAndreevich_1920x1080.jpg", 1231235], ["029768.jpg", 139215], ["159106.jpg", 1536238], ["059286.jpg", 54645], ["58D954D72C4321E595F50BF976383F78_428_600.JPEG", 154454], ["6F23B4009E416AFD6FB7178F5515D5B1_500_313.jpg", 24997], ["137344.jpg", 1776760], ["Nature (270).jpg", 1608414], ["Screenshot1.png", 802987], ["DFDB34F4854ECC3B5C24D6DB8A68D43F_500_709.jpg", 141447], ["Screenshot3.png", 943736], ["Screenshot4.png", 1211569], ["Screenshot5.png", 445869], ["Screenshot7.png", 1131832], ["9F5E767E424FD5EF15BCF408124E6452_500_500.jpg", 122472], ["two2560.jpg", 1289947], ["city_lights_bw_by_abdelrahman-d4df6mz.jpg", 1068128], ["Nature (271).jpg", 1706494], ["978B36EAEDEE9FA4A8769F4FC48AB909_500_345.jpg", 59657], ["7D8CBC119A428B7F6CC55B0FF278F402_500_394.jpg", 126814], ["browny70_desktopsmall.jpg", 266895], ["night sky.png", 1069196], ["152947.jpg", 1386995], ["80BA25EC4801AAD48AD94887696D4186_500_571.jpg", 153108], ["3AEABF1C2E30D76ED011DD562B395AF5_500_500.jpg", 207771], ["Nature (272).jpg", 1333701], ["2560x1600.jpg", 1987453], ["96421D9992B7828FB49C70C0377C795E_500_375.jpg", 117161], ["ED11DEB4C2237B908489E42EF5EFA74A_500_375.jpg", 88307], ["Tilt-Shift-New-York_1920x1080.jpg", 1311321], ["838133.jpg", 71675], ["092249.jpg", 120656], ["Eiffel Tower.jpg", 483734], ["1.jpg", 595706], ["2.jpg", 588831], ["Nature.bmp", 5553654], ["Nature.jpg", 3312786], ["91A3B4B919672F6C0B2A9DD8865999E7_480_600.JPEG", 211922], ["3.jpg", 553958], ["4.jpg", 671627], ["freedoms_and_empires_by_peehs-d4mrnr3.jpg", 987723], ["5.jpg", 368786], ["BB1F6B18F78BA6816A470971877E1DF0_500_400.jpg", 127245], ["6.jpg", 482448], ["F9FAF4BACE663A315A3F166FE5DA7393_500_391.jpg", 166124], ["7.jpg", 665990], ["159150.jpg", 1848552], ["7731AB56CCA6201BE39B2A7C5D140014_500_740.jpg", 109627], ["8.jpg", 456547], ["E4377AFCB1D21AD41203DA84B6EF9947_500_333.jpg", 37980], ["9.jpg", 762010], ["swisspic20051204_6288711_2.jpg", 266877], ["Nature (274).jpg", 1125697], ["wallpaper-748924.jpg", 130318], ["swisspic20040331_4836695_2.jpg", 146277], ["swisspic20050505_5755858_2.jpg", 319620], ["Nature (275).jpg", 1514436], ["Nasacar_Watkins_Glen.jpg", 218950], ["A65BE865F75403F698239D70D1C1EE26_500_533.jpg", 132464], ["nycnight1920.jpg", 1263290], ["swisspic20040428_4900613_2.jpg", 214108], ["architec029.jpg", 417650], ["scifi_wallpaper.jpg", 354914], ["Nature (276).jpg", 802045], ["NatureRock 2560x1600.png", 6391113], ["F338E3E5780AAC943EA2DF16C056D4BC_500_333.jpg", 24219], ["9D99ED3BE501AED38CC3842401A8C025_500_500.jpg", 95072], ["B5D44627575E3EC164A2A74EF0BED54F_900_900.JPEG", 143162], ["soviet_march.mp3", 4477240], ["swisspic20081015_02.jpg", 157925], ["swisspic20081015_03.jpg", 123429], ["swisspic20081015_04.jpg", 73727], ["1535309830E252280C2CB1FEFFC9C8E0_500_500.jpg", 188154], ["Nature (277).jpg", 954423], ["studio 817 (62).jpg", 922179], ["swisspic20081015_07.jpg", 218876], ["SkyEdge 1920x1080.jpg", 371436], ["4DBD60C136104EAA65637B6A88B0FA0C_500_578.jpg", 57775], ["87BA1564FF5B069EA24E8DE867D614A4_500_500.jpg", 92883], ["Sea Pebbles.1440x900.jpg", 477983], ["something_borrowed_desktops.jpg", 119173], ["E9B8691E2602E28D00442CE8782A32E3_500_500.jpg", 152337], ["Nature (278).jpg", 1912085], ["San_Francisco_1920.jpg", 1045714], ["9D00A77C5B3F5E7E729F2C304AF9A3BD_500_500.jpg", 67470], ["wheat.jpg", 2730538], ["407284AC23E2C6257F5C09D126595AE6_600_600.JPEG", 288048], ["gezfry.jpg", 33491], ["swisspic20060401_6596912_2.jpg", 180371], ["Kong_Hong_1610.jpg", 2745956], ["0D0BA81EFD22D39952E74CF32DC99F2B_500_500.jpg", 138467], ["NMAE.jpg", 1191665], ["2A7C6B56227DCE0698E546358162F021_500_496.jpg", 148334], ["Nature (279).jpg", 814951], ["studio 817 (64).jpg", 300044], ["37FDBFB67C56187BC3ED8813A3567342_500_365.jpg", 86287], ["w.jpg", 165402], ["01890_taipei101_1440x900.jpg", 820311], ["BC38B9D7A32798A097177918AF0C703F_500_680.jpg", 428630], ["D23A4488A5E4ED1DF9FD00A2DBFF5F28_500_707.jpg", 150943], ["tokyo-bay-on-guilty-crown.jpg", 558943], ["Unknown_Area_1920_1200.jpg", 1173452], ["740221AD022E401298D88D17E9CCA495_500_346.jpg", 100216], ["Red Bells.jpg", 1619973], ["D8E9917E0BA3C4B32ABAF7694D56A8C4_500_714.jpg", 176993], ["swisspic20040408_4853602_2.jpg", 181114], ["C347D7241592271819AD1D4B988F27CF_500_1000.jpg", 783497], ["CA9B600347D68D7E23B0FCEA8A36C50A_500_708.jpg", 463370], ["Nature (280).jpg", 1617402], ["C6143188E766AEACFF8E99E154F41287_500_349.jpg", 253431], ["swisspic20040324_4816631_2.jpg", 181663], ["147057.jpg", 55129], ["switzerland.jpg", 237389], ["Untitled-1.jpg", 1520098], ["CD8DABFC518A2F4000A9E03D2282B4D5_500_500.jpg", 26012], ["swisspic20060711_6886628_2.jpg", 229612], ["BE735AED1A0153C98064163B33DBC33D_500_375.jpg", 46667], ["water.jpg", 2933406], ["153635.jpg", 1085748], ["swisspic20040326_4822516_2.jpg", 132026], ["DCC3E953B746BAA1C0F188B1E38B1CA6_500_740.jpg", 105185], ["163248.jpg", 2053861], ["swisspic20060321_6566334_1.jpg", 280825], ["1B89AF22A8EAF7FBB5A7BB497DA20D5B_500_334.jpg", 105532], ["C3370549E7AE155E86D321BBB5D3FF5C_500_354.jpg", 83974], ["414E024B0ADAEE8931DCCA77E5EE685E_500_400.jpg", 152724], ["snapshot20090322163408.jpg", 216762], ["Nature (283).jpg", 378045], ["zleaf.png", 3555295], ["14B2EFD4B2664EF4DD1091DA49171140_500_500.jpg", 53560], ["realstars1080p.jpg", 829420], ["the_ruins.jpg", 194019], ["Nascar_Daytona_night.jpg", 252742], ["52C52BC57D3F53B1FAA309B352A96821_430_430.JPEG", 37594], ["tunb 1920x1200.jpg", 640360], ["Nature (284).jpg", 564067], ["Nature (343).jpg", 1692205], ["3EE27E902853791AF2ABF34DDFDBF5FE_500_289.jpg", 51126], ["heimenschwand_II.jpg", 78027], ["9A36836F629BFFBC8D7C5D0F83F255F3_500_500.jpg", 82077], ["50_50_desktops.jpg", 74097], ["Nature (285).jpg", 513592], ["pon_de_lion_desktops.jpg", 57223], ["19CBE63EBA40526CD6B25ABA2C4BA14D_500_263.jpg", 76736], ["Summertime_Blues-1920x1200.jpg", 1803659], ["Nature (286).jpg", 869042], ["F8CB089257BD79AFA6DCE1B43EB2886F_500_339.jpg", 134162], ["16 (2).jpg", 449872], ["music_combat_10.mp3", 2013391], ["Solstice_by_IvanAndreevich_1920x1200.JPG", 1710198], ["1440x900 (5).jpg", 728441], ["remembrance_ii.jpg", 468520], ["486512.jpg", 78659], ["4F0AB220A2F22E5795BA82A3107D2E1C_500_347.jpg", 78131], ["4E0CED175AE066CD36E77900ACF8E236_500_372.jpg", 26410], ["swisspic20051001_6130292_2.jpg", 225869], ["2929081700_718f4e8c1f_o.jpg", 1469696], ["spring -1920X1080.jpg", 1299689], ["Poseidon's_Wrath_.jpg", 2731758], ["261948.jpg", 111615], ["AD1102D548FB0EB186A79A236674F60F_800_800.JPEG", 141380], ["Screenshot13.png", 982536], ["Screenshot14.png", 1177303], ["zurich1.flv", 8377422], ["swisspic20040717_5090820_2.jpg", 111080], ["zurich2.mp4", 18993208], ["16 (4).jpg", 1660530], ["zurich3.mp4", 18811737], ["zurich4.mp4", 13032722], ["B06BDC580AE88CB81C22174A674443DB_500_417.jpg", 189819], ["zurich5.mp4", 20182087], ["Screenshot20.png", 1178503], ["Screenshot21.png", 898893], ["4298A0D06EDAF1094B335734356EA238_500_353.jpg", 145234], ["swisspic20050730_5977113_1.jpg", 158346], ["towers_of_fluf.jpg", 1279756], ["3A8C396D79C6DA09EC1506B850260BCD_500_500.jpg", 309240], ["BF8763DB150D071D01FD57117D508F7E_500_434.jpg", 156902], ["158707.jpg", 68717], ["16 (5).jpg", 1988449], ["776E202A3A99F9EC3FAF34098D33BC1E_500_430.jpg", 118608], ["sky2_desk_photodoom.jpg", 1012178], ["swisspic20050827_6041806_0.jpg", 105550], ["Pine_1920x1080.jpg", 732971], ["27886779AED9581F8429429802F693EF_500_364.jpg", 193809], ["6B901DD77A12511766E5DEBF36A131B6_500_334.jpg", 103943], ["4DB90A57B256D1230FDAB46759E101AD_425_600.JPEG", 156447], ["downsample.jpg", 78071], ["01908_thecityoflights_1440x900.jpg", 1732801], ["158721.jpg", 1255111], ["Nature_Veins.jpg", 1475849], ["879BACBE5896B4284147E7CA1788894B_500_545.jpg", 59685], ["158040.jpg", 1203290], ["BEED86269DDEDBF2F6E4CA3E8AAB9AE4_500_695.jpg", 160390], ["1 copy.jpg", 339974], ["nature_0093.jpg", 574181], ["nature_0094.jpg", 594012], ["F76599FE0A2B9BF2C437D1AAFAFBE30F_500_367.jpg", 70845], ["albion-005.png", 41771], ["swisspic20050730_5977132_2.jpg", 209403], ["Eiffel 1680.jpg", 207432], ["36F5CF3EE07C6E4F57FD0FD90D6F1608_374_500.JPEG", 122053], ["88CF553546123FCB7AE8E0BB16664227_400_600.JPEG", 59825], ["02790_lifeinny_1920x1080.jpg", 2532278], ["48E5A2E4FEAD0F02996EDF57C98D135F_400_600.JPEG", 56176], ["Welcome to heaven -1920 x 1200.jpg", 900498], ["Nature (292).jpg", 484488], ["Screenshot8_001.png", 857761], ["The Path 2 1920x1200.jpg", 466060], ["641DEFEBF71F384B4C481B1F8B96660E_500_500.jpg", 48786], ["Sunshine_1920x1080.png", 4606930], ["FBBE485FF5454780FE5B3F621F2E9ED2_500_318.jpg", 82109], ["a.jpeg", 144400], ["02650_timessquare_1920x1080.jpg", 1857109], ["109234.jpg", 134898], ["876292.jpg", 68709], ["Swamp_by_IvanAndreevich_1920x1200.JPG", 953672], ["7A6F1DC0F86C62B7FF3C287D40362E4E_500_743.jpg", 112837], ["wallpapers_000031_by_dzhyein-d4i48ji.png", 5389588], ["Castt1920.png", 4799921], ["1440x900(16).jpg", 472848], ["swisspic20050913_6083963_0.jpg", 95530], ["C9E738BDDF3E7D39AAF36283883DE839_500_736.jpg", 327461], ["swisspic20040325_4820509_2.jpg", 194668], ["Woodz_1680x1050.png", 1567538], ["1440x900(17).jpg", 646293], ["1EB3416A648E906646AFCF8E214AC251_500_396.jpg", 39316], ["tenganans.jpg", 123627], ["swisspic20051208_6299600_0.jpg", 202731], ["01222CE1AA58C04F44CF7C2D28B08D6A_500_429.jpg", 200224], ["swisspic20040326_4822085_2.jpg", 166949], ["new_york_wallpaper___plain_by_jamesdeanee-d41p7uj.jpg", 2769579], ["9FEE2F11A61DFECE0B9CA1EB502D0CF8_501_339.jpg", 55925], ["1440x900(18).jpg", 289873], ["31E8E2826A683B268D72CB04F3966154_429_600.JPEG", 292893], ["A3BDA213D070A07C19E848F4EB8B3923_500_500.jpg", 118352], ["5CFF9C928F28FC7B9A698E63F7A7EC36_500_500.jpg", 284133], ["Would.jpg", 4775374], ["B28A0B92D35926C66317493DF791BDB5_500_375.jpg", 88002], ["1600x900.jpg", 1061050], ["7AD730D66C5389652A596AD051AACCED_500_500.jpg", 158273], ["1440x900(19).jpg", 521612], ["Sunset_Tower.jpg", 184093], ["World_Switzerland_Swiss_Countryside_007916_.jpg", 476695], ["BDC45EAA707FF85B9C2628C5213B08D8_500_708.jpg", 55854], ["40BAF4CCDA3DFEE614FE1234F1B86E1C_500_500.jpg", 371422], ["swisspic20040322_4809834_2.jpg", 311308], ["053F399321E727D10AD4AD357642324D_500_500.jpg", 191778], ["790CBB884D405C392843347F28DF512F_500_524.jpg", 142700], ["743C94D8000FF3C53C5D77226C058643_500_500.jpg", 186087], ["The Frozen Cherry by IrvingGFM Widescreen (2).jpg", 613237], ["swisspic20060128_6420946_2.jpg", 274733], ["F02BEE365F5935B2C77CD91D1F892193_500_500.jpg", 296961], ["0D836FE581DC893A57CF79B36236E1ED_500_708.jpg", 133529], ["4D3C0128497B1797A84278ABD0DADD92_500_500.jpg", 76636], ["C880CDE5A6C298C4F85716E8F6873EF2_500_702.jpg", 256199], ["C8F2D082D81E0E3107C183861008F5B5_416_498.JPEG", 58011], ["55DFAC54834895AD45C55E939778E632_500_500.jpg", 125363], ["The Frozen Cherry by IrvingGFM Widescreen (3).jpg", 491920], ["new_york-1680x1050.jpg", 468083], ["806EB2F06FCB2AE24D75E3B53AD9B99F_430_322.JPEG", 22888], ["E7121F293BFB6F52DA15BD844C525D6B_500_775.jpg", 504459], ["59E6B2ADFCE50201D15E5AA67EDA7F25_500_353.jpg", 183345], ["swisspic20040726_5106638_2.jpg", 240096], ["swisspic20041113_5339205_2.jpg", 202593], ["springtime.jpg", 625448], ["Sleep_Away.mp3", 4842585], ["F82775A7A64AF212746E40275EE5B9EC_500_570.jpg", 138976], ["zDragons Lair Nebula.jpg", 1018227], ["swisspic20040320_4805457_2.jpg", 148888], ["Warmth_by_IvanAndreevich_1920x1080.JPG", 1482593], ["endeavours_sc3_1920.jpg", 299691], ["0C1A4BFA2F0419D2B70B7EFD638CECC6_500_500.jpg", 178603], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-15.jpg", 1165411], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-16.jpg", 938492], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-17.jpg", 1196839], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-18.jpg", 2018641], ["0175EBC0CA897B6E0AE343ED08B862B3_500_542.jpg", 123842], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-19.jpg", 1685201], ["154425.jpg", 1656140], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-20.jpg", 2205074], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-21.jpg", 1816637], ["Hamad_Darwish_dot_com_Windows_Vista_Wallpapers_-22.jpg", 1664158], ["09B1E82EF735AC1DB45C3B2FABFEBC0F_500_668.jpg", 131646], ["154429.jpg", 2213017], ["abstract wallpapers_00042.jpg", 120529], ["FB2846BE7128F5E3E0782DDC1FAB9431_500_375.jpg", 334098], ["swisspic20040326_4822478_2.jpg", 134699], ["063625.jpg", 49472], ["1342690123587123.jpeg", 294320], ["ws_Beautiful_Switzerland.jpg", 113594], ["altman ebenalp switzerland wallpapers 1024x768.jpg", 277762], ["01892_colorsofnewyork_1440x900.jpg", 1373978], ["download.jpeg", 166492], ["500606.jpg", 81404], ["1935B1DF221264E19F9C87A226FEBFB0_500_497.jpg", 140482], ["swisspic20040322_4809262_2.jpg", 243261], ["swisspic20051204_6288720_2.jpg", 125494], ["544F39C3538E3A03B0F4BA9A6CA04485_500_709.jpg", 113817], ["4D851DB326AE23535949A86B1A496275_500_281.jpg", 43900], ["66F1A86ECC84E8956D1CBF27B7552415_608_900.JPEG", 246507], ["zA\314\203\302\274rich-wallpapers_25801_1440x900.jpg", 394261], ["25659E3860D9A1EEEF8CD8D70B5A9F3D_500_500.jpg", 239630], ["56383559393F4D1228EA567CFE72BCD4_460_601.JPEG", 493084], ["94E75FEC73A4D8C619A21E1DBC361BAF_500_656.jpg", 67977], ["Through Clouds wallpaper 2560x1440.jpg", 1362540], ["CA9808C2EC7FAD58FF7E4A02C10F1794_466_600.JPEG", 62010], ["651D0CC90CE1D84C599439ACF2D1ADF8_500_500.jpg", 31449], ["trees.png", 4755662], ["B6B35DFB6D024682022996599DDC188C_500_531.jpg", 152532], ["gezfry03.jpg", 54492], ["gezfry04.jpg", 59734], ["rinari-demo.small.ogg", 20016900], ["01740_rockefellersview_1440x900.jpg", 905962], ["089866.jpg", 83544], ["927429.jpg", 43291], ["Summer_1920_left.jpg", 1638496], ["Ny 1900x1200.jpg", 562031], ["swisspic20040416_4870190_2.jpg", 243865], ["road_to_nowhere_iv_by_c31marius-d4qiieq.jpg", 2312023], ["A21E12B800290B5D4F62EBEC42838BC5_479_600.JPEG", 408741], ["38B7F8A8742EF1E7CCFA66ED0C889EF2_500_708.jpg", 364759], ["swisspic20040426_4894466_2.jpg", 138884], ["1680x1050.jpg", 2088293], ["528032.jpg", 118264], ["000016ss.jpg", 81026], ["SummersDay1920x1080.jpg", 996373], ["4588869C0B437D268535C9401DD846CA_430_600.JPEG", 421853], ["7536BF00ED06167AFBDC76DBA07600F8_500_357.jpg", 110552], ["177D05D9C8C1C1F616067C76A99C8452_500_707.jpg", 79588], ["E0A8C1EA076DD4D63CC8981B006016F0_500_1041.jpg", 142178], ["Point of Destiny 1920x1200.jpg", 1020827], ["wide_.jpg", 1546460], ["TangolundaBay_by_IvanAndreevich_1920x1080.jpg", 1226437], ["E56923DDE2DC04237DBB6D68D1ED5D7F_500_334.jpg", 38087], ["CB4037078228221E2EC0D4B47E86AC77_500_384.jpg", 298111], ["Sunset on City 1920x1080.jpg", 1932089], ["341DF065D841991AF10F61E9F5C22909_500_343.jpg", 43289], ["wroad.jpg", 1452887], ["2BE161367A4C85BB18DE105CF8D866B1_480_600.JPEG", 188184], ["01722_roadtoamerica_1440x900.jpg", 1032115], ["03A93357144D01BA83AAA21503F9D7A1_500_681.jpg", 253202], ["temperateRainforest.jpg", 783392], ["viaduct_stursanne.jpg", 259217], ["Pillars of Hope 1440x900 WS.jpg", 601652], ["89A37E5F0CBC6E79F564C719BD897948_500_577.jpg", 164258], ["Nature (303).jpg", 1035124], ["26C4D0327B6A7CA33178616F1988E156_500_353.jpg", 193465], ["swisspic20040320_4805470_2.jpg", 154928], ["Palace.jpg", 4468025], ["6EC0FB2B08893777D5A390AC30E3708D_500_704.jpg", 148006], ["percivus_wallpaper_1.png", 2414083], ["54E94B4530F62F37A3C6C9111FB7BD66_500_356.jpg", 118658], ["shadowOfIo.jpg", 342368], ["skyhigh_hh_1920.jpg", 394715], ["Surrounded.png", 3421941], ["percivus_wallpaper_6.png", 2178893], ["wideawake_1920.jpg", 551791], ["Other_Times.jpg", 2172562], ["swisspic20051001_6130226_2.jpg", 258532], ["194366.jpg", 46824], ["02630_sunsetinthebigcity_1920x1080.jpg", 1494870], ["Purity_by_IvanAndreevich_2560x1440.JPG", 1412273], ["See the world.jpg", 1838823], ["3D93BABE97B6B3992EEDBF9843B1BA1F_500_375.jpg", 19521], ["Nature (306).jpg", 2722544], ["47E24D814D0E1EC75F52580B464FD491_500_332.jpg", 25798], ["01799_brooklynbridge_1680x1050.jpg", 681608], ["specula1920.jpg", 1110516], ["35D779F97AB1EEFB2993A77FE401A5FF_500_709.jpg", 56903], ["8233C549656A0B203DDF48CEECE1FE78_425_600.JPEG", 163053], ["B36B0011350EE06118FCB64EA1D8E3A7_500_500.jpg", 92728], ["022675.jpg", 65762], ["669712.jpg", 60889], ["swisspic20040322_4809379_2.jpg", 252828], ["lf_1920.jpg", 577440], ["swisspic20040322_4809077_2.jpg", 260435], ["73D0A2394DE73D4B305B45ED0C2D5276_500_600.jpg", 210659], ["viridis_1920x1200.jpg", 1610876], ["10.jpg", 228463], ["11.jpg", 637145], ["12.jpg", 785405], ["winter2.jpg", 2329701], ["EB8F478A1380C3BBBE595DF4ACF97A6F_500_723.jpg", 389088], ["377E8CCCEC7908EDA808148941FF5428_500_500.jpg", 204796], ["Network.jpg", 3098433], ["422BCFEE7DA79F4B4C2D46AEC2AE5668_500_281.jpg", 31117], ["endeavours_sc4_1920.jpg", 483043], ["F505AB7E6CCCE49BD32E1797BED92A13_500_500.jpg", 115130], ["BE4AC84B264746443D1A47BDBF98A684_500_500.jpg", 247390], ["swisspic20041006_5258574_2.jpg", 336743], ["swisspic20051219_6329821_1.jpg", 73520], ["02FE87780099564D3ECE9E17E2A46F0E_500_675.jpg", 93915], ["The Path 1920x1080.jpg", 661751], ["Nature (250).jpg", 567272], ["267180.jpg", 55189], ["6C2D432D0A4FEF44CBB0BEF2A5A3C6D4_500_334.jpg", 119684], ["D1B9BED6EB499D3363CBA724C13A3DB3_480_600.JPEG", 270032], ["5FE4B06DA3B21B21002DDBEDEF0E8FE6_500_300.jpg", 110737], ["8A63E5F387B05275EFAEE92BC580616C_500_500.jpg", 125463], ["Star_Wars.jpg", 871933], ["2EF2B03EF2FA94A4FB036CAD5DED5F86_500_434.jpg", 138428], ["tuc_1920.jpg", 824884], ["Planetary_Equilibration.jpg", 542615], ["40D29EE243903839E4F8E635151DD9DD_500_389.jpg", 23633], ["Stormy-Road.jpg", 878775], ["801543FC2203CFAFECACAB0E76BCF2B1_500_492.jpg", 406045], ["Nascar_Dockside.jpg", 292781], ["PuertoVallarta_by_IvanAndreevich_1920x1200.JPG", 1441147], ["swisspic20040809_5132571_2.jpg", 194614], ["Nature (252).jpg", 2187011], ["20E84EE6138BD4B668B0D8D3A89FE787_498_491.JPEG", 58524], ["7FDE9DA14BC740A5B52A0E4B59A26C64_500_600.jpg", 18234], ["swisspic20040321_4807224_2.jpg", 236268], ["swisspic20040426_4894731_2.jpg", 210476], ["9E929902307D9801427922BB8E360075_500_500.jpg", 289087], ["440912049A0D3DD483470B82722671A8_400_551.JPEG", 112377], ["back_to_basics_desktops.jpg", 165330], ["Sun.jpg", 819228], ["C48774F749FB86C251EECFB7332BC767_500_367.jpg", 55454], ["The Homeworld.jpg", 1620506], ["1374CAEF393EE9BBD2C3ED9AB9B7E3E0_412_600.JPEG", 378730], ["E4EC574198B490CEAA0093B6EC7FFB90_500_348.jpg", 74952], ["969954.jpg", 60773], ["swisspic20041024_5292212_2.jpg", 240133], ["38104EAE5FEDDD35F4888580ED70F0A3_500_292.jpg", 129116], ["676BABDBC6146EC6AB0BBD5D9722D66B_500_500.jpg", 178679], ["32E0B81689C819B279D0215F5B82EBE4_400_600.JPEG", 96968], ["swisspic20040324_4816352_2.jpg", 191747], ["C7759B75DA661757E7CAA424BE3432FB_500_363.jpg", 95787], ["Nature_Paradise.jpg", 1615582], ["572696.jpg", 115312], ["swisspic20040427_4897885_2.jpg", 162148], ["strange_news_1920.jpg", 515576], ["A569FE8FF5425DC5049027B9AB7427A7_423_600.JPEG", 248112], ["soft-2560 x 1440.jpg", 1304360], ["swisspic20040408_4853638_2.jpg", 210952], ["zcity (1).jpg", 1373180], ["zcity (1).png", 3004673], ["SeaLine1920x1200.png", 3207880], ["03CFCC4EF12B88C18664981C9D5EDDCB_500_745.jpg", 481826], ["EB3800015132271DDDFAB4E661C090F5_500_721.jpg", 515027], ["zcity (2).jpg", 2038603], ["289B22D01CD93A65F37231D0725D461B_500_344.jpg", 70275], ["712124430D73B4695C1907D45111F3FE_500_331.jpg", 36800], ["2798C6C4FB173D65B2EEBD4469C43200_500_500.jpg", 109579], ["swisspic20040322_4809482_2.jpg", 156285], ["476624.jpg", 40744], ["swisspic20040322_4811369_2.jpg", 201102], ["111.gif", 176794], ["zcity (3).jpg", 1277216], ["010615.jpg", 98592], ["swisspic20051213_6312921_0.jpg", 160753], ["CDEE9FF84AE93F01DE62A2DA7EB60632_500_417.jpg", 127997], ["Origins.jpg", 2023981], ["34C7A11AD2E8190F68AB4D887FC19D68_500_500.jpg", 125119], ["80CD87775741727B09E48736F4221CF4_500_351.jpg", 73224], ["zcity (4).jpg", 433478], ["Unteraargletscher-Switzerland.jpg", 673734], ["6EE9305ED402D15BB665B5B2F6F2EA35_500_740.jpg", 113085], ["Nature (260).jpg", 2163330], ["AF5AB98F8E7AFE1662FADE13D6797B2C_500_342.jpg", 125832], ["EE0E5C3B3FCB9FFF720657BCFC8623D8_500_804.jpg", 230442], ["zcity (5).jpg", 390374], ["swisspic20051219_6329726_1.jpg", 308754], ["wallpaper-451352.jpg", 1234930], ["8FDEA0E9FAA4B68B670867A3E9D0E2B4_500_580.jpg", 230285], ["058A8C1F99018B0D98636BA3C5E9CB2C_500_370.jpg", 98253], ["sky_desk_photodoom.jpg", 926736], ["Nature (261).jpg", 1493920], ["B79651E7A52C40FEE77ED44C09E22C90_500_375.jpg", 47485], ["zcity (6).jpg", 555048], ["C2EF643CE2C39EF2BE353585873A53A4_500_335.jpg", 90076], ["wp-lake.hd.jpg", 1565771], ["425271.jpg", 96900], ["C1F0CE9EA67CC2FA8FFDE388C2CC9FAB_500_355.jpg", 115438], ["FE035E4DBDCD49F6B50B130D29DD6E1E_500_356.jpg", 107806], ["065083.jpg", 70477], ["9FB46C1D13180CC2249248D8E6AD4240_500_500.jpg", 192727], ["Nature (262).jpg", 2220840], ["zcity (7).jpg", 288256], ["4DAA77B72C1643E159EE21213EB1D0DC_500_703.jpg", 508950], ["99BAF211198C34A2557D91D7485B1A4F_500_500.jpg", 87431], ["Hong_Kong_at_night.jpg", 1249028], ["2D26E162803AEB0385465029E8E9FCAB_500_788.jpg", 493834], ["swisspic20050903_6059509_1.jpg", 359858], ["SecretLair_by_IvanAndreevich_2560x1440.JPG", 2809043], ["78F98D8E1765520A9A26ECBC93FB98AC_500_702.jpg", 256199], ["8D31F18DB5060BC39ABC1C4DCB4D2237_450_600.JPEG", 292128], ["Nature (263).jpg", 1690193], ["swisspic20060710_6884770_0.jpg", 192750], ["68F321BA51E25EBFA73DBB78EB7280C6_500_707.jpg", 182056], ["854903.jpg", 91983], ["miniature_tokyo_by_eonik-d4dn36o.jpg", 1414294], ["swisspic20051206_6293120_2.jpg", 163708], ["swisspic20040322_4809401_1.jpg", 247324], ["music_combat_1.mp3", 2491954], ["Nature (264).jpg", 1221895], ["music_combat_2.mp3", 1947771], ["2EE23B46140AE0867475D2E1DE37498F_500_500.jpg", 84299], ["C81AE14D27DB94E7B08F477BA2BE8403_500_358.jpg", 114286], ["music_combat_3.mp3", 1923530], ["Springtime_2560x1600.jpg", 3279057], ["686635.jpg", 71246], ["music_combat_4.mp3", 2036797], ["0DD5B6366B7597F8F8D47DF903280F01_500_500.jpg", 162326], ["music_combat_5.mp3", 2003778], ["swisspic20051210_6305461_0.jpg", 267343], ["music_combat_6.mp3", 1900124], ["music_combat_7.mp3", 2243686], ["F0C95ED3115DE2D13FC81FCFDE8381A5_500_706.jpg", 132360], ["Origin 1200x800.jpg", 395661], ["music_combat_8.mp3", 1983716], ["something_old_desktops.jpg", 68418], ["music_combat_9.mp3", 2172633], ["45DEF28ABA6EC033BBD1F7207B5400C6_500_500.jpg", 155771], ["Nature (265).jpg", 1341367], ["Droplet.jpg", 562170], ["Paradise Lost 1440x900 WS.jpg", 666691], ["cosmopolis_by_liquidsky64-d4l1phh.jpg", 1322707], ["swisspic20040321_4807397_2.jpg", 128355], ["662320.jpg", 78976], ["381 Landscape and Cityscape HQ Wallpapers 0351.jpg", 828683], ["Nature (266).jpg", 2609454], ["381 Landscape and Cityscape HQ Wallpapers 0352.jpg", 522419], ["Twilight_by_IvanAndreevich_1920x1080.JPG", 617693], ["D60C04B278325A88C4898C89D1D14C89_500_217.jpg", 106260], ["126415.jpg", 3308824], ["159081.jpg", 2424163], ["A7B3E458DF56461871F73295A1F7FF49_500_380.jpg", 97108], ["8F7170A61CBA20F47039185B8819FBD3_500_500.jpg", 145828], ["Nature (267).jpg", 1983872], ["nature wide.jpg", 1851069], ["Orifice 1440x900.jpg", 1310373], ["endeavours_sc5_1920.jpg", 299528], ["381 Landscape and Cityscape HQ Wallpapers 0367.jpg", 393745], ["E78DB0D3813B4B910E14138D7306DBF7_500_500.jpg", 151405], ["tabinotochuu.mp3", 6094976], ["D38ECE3204034BB32EF261356671007C_500_375.jpg", 46862], ["FH060005s.jpg", 118252], ["Point Of Honour.jpg", 734921], ["DC36AF1B61EE7E31674BB918785A6421_425_600.JPEG", 216991], ["144474.jpg", 1465156], ["dial_tone_desktops.jpg", 73892], ["672FE2DEAF40B487C501DF9A00A54239_500_325.jpg", 95994], ["planet1600x1200.jpg", 371487], ["381 Landscape and Cityscape HQ Wallpapers 0379.jpg", 1493728], ["Chateau-De-Chillon-Montreux-Switzerland-1-1600x1200.jpg", 259003], ["B7E6FD5082F76A8C0AF91AD52D5FA73C_500_358.jpg", 153768], ["snowflakes2_by_kxhara-d4mo0px.jpg", 1695541], ["Nature (269).jpg", 1225252], ["Points_Of_View.png", 1999440], ["athens-1920x1080.jpg", 1543693]]

file_names_and_sizes.each do |f|
  record = MediaFile.create(
    :file_file_name => f[0],
    :place => 'edu',
    :creator => creator,
    :file_content_type => file_content_type(f[0]),
    :file_file_size => f[1],
    :file_updated_at => DateTime.now,
    :file_merged => true,
    :video_encode_status => 'SUCCESS'
  )

  puts "==== record-#{record.id} created!"
end


puts '======== assigning media_files with categories....'
mfs = MediaFile.all[0,495]
start_number = 0
Category.leaves.each do |c|
  c.media_files.concat(mfs[start_number, 4])
  start_number += 4
end
puts '======== done!'

puts '================ done! ================='
