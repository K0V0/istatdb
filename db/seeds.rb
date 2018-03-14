
# create root user
User.create(:email => 'admin@admin.hsdb', :password => '1234567890', :password_confirmation => '1234567890', is_admin: true)

uom_types = [
    { id:1, uom_type:"EUR", full_name:"Euro", description:"cena" },
    { id:2, uom_type:"kg", full_name:"Kilogram", description:"hmotnosť" },
    { id:3, uom_type:"g", full_name:"Gram", description:"hmotnosť", intrastat_code:"GRM" },
    { id:4, uom_type:"m3", full_name:"Kubický meter", description:"objem rozmerový v m3", intrastat_code:"MTQ" },
    { id:5, uom_type:"x 1000 m3", full_name:"tisíc Kubických metrov", description:"objem rozmerový v m3 x 1000", intrastat_code:"MQM" },
    { id:6, uom_type:"m2", full_name:"Štvorcový meter", description:"plocha", intrastat_code:"MTK" },
    { id:7, uom_type:"m", full_name:"Meter", description:"dĺžka", intrastat_code:"MTR" },
    { id:8, uom_type:"l", full_name:"Liter", description:"objem", intrastat_code:"LTR" },
    { id:9, uom_type:"c/k", full_name:"Karát", description:"(1 metrický karát = 2 x 10-4 kg)", intrastat_code:"CTM" },
    { id:10, uom_type:"ce/el", full_name:"Počet buniek", description:"počet buniek", intrastat_code:"NCL" },
    { id:11, uom_type:"t", full_name:"Tona", description:"prepravná kapacita/nosnosť v tonách", intrastat_code:"CCT" },
    { id:12, uom_type:"gi F/S", full_name:"Gram", description:"gram štiepiteľných izotopov", intrastat_code:"GFI" },
    { id:13, uom_type:"kg H2O2", full_name:"Kilogram", description:"kilogram peroxidu vodíka", intrastat_code:"KNS" },
    { id:14, uom_type:"kg KOH", full_name:"Kilogram", description:"kilogram hydroxidu draselného", intrastat_code:"KPH" },
    { id:15, uom_type:"kg KPO", full_name:"Kilogram", description:"kilogram oxidu draselného", intrastat_code:"KPO" },
    { id:16, uom_type:"kg met.am.", full_name:"Kilogram", description:"kilogram metylamínu", intrastat_code:"KMA" },
    { id:17, uom_type:"kg N", full_name:"Kilogram", description:"kilogram dusíku", intrastat_code:"KNI" },
    { id:18, uom_type:"kg NaOH", full_name:"Kilogram", description:"kilogram hydroxidu sodného", intrastat_code:"KSH" },
    { id:19, uom_type:"kg P2O5", full_name:"Kilogram", description:"kilogram oxidu fosforečného", intrastat_code:"KPP" },
    { id:20, uom_type:"kg 90% sdt", full_name:"Kilogram", description:"kilogram látky 90% suchej", intrastat_code:"KSD" },
    { id:21, uom_type:"kg U", full_name:"Kilogram", description:"kilogram uránu", intrastat_code:"KUR" },
    { id:22, uom_type:"MWh", full_name:"Megawatthodina", description:"1000 kilowatthodín", intrastat_code:"MWH" },
    { id:23, uom_type:"x 1000 l", full_name:"tisíc Litrov", description:"objem tekutiny x 1000 litrov", intrastat_code:"KLT" },
    { id:24, uom_type:"l alc. 100%", full_name:"Liter", description:"liter čistého (100%) alkoholu", intrastat_code:"LPA" },
    { id:25, uom_type:"pa", full_name:"Pár", description:"počet párov", intrastat_code:"NPR" },
    { id:26, uom_type:"pcs", full_name:"Počet kusov", description:"počet kusov", intrastat_code:"NAR" },
    { id:27, uom_type:"x 100 pcs", full_name:"Počet sérií po 100 kusov", description:"počet x 100 kusov", intrastat_code:"CEN" },
    { id:28, uom_type:"x 1000 pcs", full_name:"Počet sérií po 1000 kusov", description:"počet x 1000 kusov", intrastat_code:"MIL" },
    { id:29, uom_type:"TJ", full_name:"Terajoule", description:"terajoule (spaľovacie teplo)", intrastat_code:"TJO" },
    { id:30, uom_type:"---", full_name:"Žiadna/iné", description:"žiadna/iná doplnková jednotka", intrastat_code:"ZZZ" }
]

uom_types.each do |ut|
    UomType.create(ut)
end

incoterms = [
    { id: 1, shortland: "XXX", description:"Iné podmienky dodania" },
    { id: 2, shortland: "EXW", description:"Zo závodu (dohodnuté miesto)" },
    { id: 3, shortland: "FCA", description:"Uvoľnené dopravcovi (dohodnuté miesto)" },
    { id: 4, shortland: "FAS", description:"Uvoľnené k boku lode (dohodnutý prístav nalodenia)" },
    { id: 5, shortland: "FOB", description:"Uvoľnené na palube (dohodnutý prístav nalodenia)" },
    { id: 6, shortland: "CFR", description:"Náklady a prepravné (dohodnutý prístav určenia)" },
    { id: 7, shortland: "CIF", description:"Náklady, poistenie a prepravné (dohodnutý prístav určenia)" },
    { id: 8, shortland: "CPT", description:"Preprava platená do (dohodnuté miesto určenia)" },
    { id: 9, shortland: "CIP", description:"Preprava a poistenie platené do (dohodnuté miesto určenia)" },
    { id: 10, shortland: "DAF", description:"S dodaním na hranicu (dohodnuté miesto)" },
    { id: 11, shortland: "DES", description:"S dodaním z lode (dohodnutý prístav určenia)" },
    { id: 12, shortland: "DEQ", description:"S dodaním z nábrežia (dohodnutý prístav určenia)" },
    { id: 13, shortland: "DDU", description:"S dodaním clo neplatené (dohodnuté miesto určenia)" },
    { id: 14, shortland: "DDP", description:"S dodaním clo platené (dohodnuté miesto určenia)" },
    { id: 15, shortland: "DAP", description:"Doručené na miesto (miesto určenia)" },
    { id: 16, shortland: "DAT", description:"Doručené na terminál (miesto určenia)" }
]

incoterms.each do |i|
    Incoterm.create(i)
end

trade_types = [
    { type: "1-1", description: "Priama kúpa/predaj" },
    { type: "1-2", description: "Dodávka tovaru na skúšku, na ukážku, na komisionálny predaj alebo na akýkoľvek predaj za províziu" },
    { type: "1-3", description: "Barterový obchod (náhrada v naturáliách)" },
    { type: "1-4", description: "Finančný lízing (splátkový obchod)" },
    { type: "1-9", description: "Iné transakcie so skutočným alebo plánovaným prevodom vlastníctva z rezidentov na nerezidentov za finančnú alebo inú náhradu" },
    { type: "2-1", description: "Vrátenie tovaru " },
    { type: "2-2", description: "Bezplatná náhrada za vrátený tovar" },
    { type: "2-3", description: "Náhrada (napríklad v záručnej lehote) za tovar, ktorý nebol vrátený" },
    { type: "2-9", description: "Iná bezplatná náhrada/vrátenie tovaru po registrácii pôvodnej transakcie" },
    { type: "3", description: "Transakcie zahŕňajúce prevod vlastníctva bez finančnej alebo vecnej náhrady (napr. dodávky pomoci)" },
    { type: "4-1", description: "Tovar určený na spracovanie (na základe zmluvy), ktorý sa má vrátiť do pôvodného členského štátu odoslania" },
    { type: "4-2", description: "Tovar určený na spracovanie (na základe zmluvy), ktorý sa nemá vrátiť do pôvodného členského štátu odoslania" },
    { type: "5-1", description: "Tovar po operáciách spracovania, ktorý sa vracia do pôvodného členského štátu odoslania" },
    { type: "5-1", description: "Tovar po operáciách spracovania, ktorý sa nevracia do pôvodného členského štátu odoslania" },
    { type: "6-1", description: "Tovar prijatý na dočasné použitie na obdobie nie dlhšie ako 24 mesiacov a tovar odoslaný na užívanie na obdobie nie dlhšie ako 24 mesiacov" },
    { type: "6-2", description: "Oprava a údržba za úhradu" },
    { type: "7", description: "Operácie v rámci projektov spoločnej obrany alebo iných spoločných medzivládnych výrobných programov" },
    { type: "8", description: "Transakcie zahŕňajúce dodávku stavebného materiálu a technického vybavenia pre stavebné a inžinierske práce v rámci všeobecnej zmluvy, v prípade ktorých sa nevystavujú faktúry za jednotlivý tovar, ale jedna faktúra za celú hodnotu tovaru" },
    { type: "9-1", description: "Prenájom, pôžička, operatívny lízing dlhšie ako na 24 mesiacov" },
    { type: "9-2", description: "Nepriamy dovoz a nepriamy vývoz" },
    { type: "9-3", description: "Premiestnenie tovaru" },
    { type: "9-9", description: "Transakcie inde nešpecifikované" }
]

trade_types.each do |tt|
    TradeType.create(tt)
end




