#https://www.indeed.com/jobs?q=css&l=portland%2C+OR&explvl=entry_level&radius=15

require("bundler/setup")
require("pry")
require("open-uri")
# require("./lib/meetup.rb")
Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

MeetupClient.configure do |config|
  config.api_key = "48216d5851293b1f446a235e597c3b"
end

meetup_api = MeetupApi.new

get('/') do
  @meetups = Meetup.all
  @jobs = Job.all
  erb(:home)
end

#do job stuff in here?
post('/') do
  Meetup.all.each do |meetup|
    if params["#{meetup.id}"] == "pinned"
      meetup.update({pinned: true})
    else
      meetup.destroy
    end

  end
  # Meetup.where(pinned: false).destroy_all

  meetup_params = { category: '34',
    city: 'Portland',
    state: 'OR',
    country: 'US',
    status: 'upcoming',
    format: 'json',
    page: '50'}
  @events = meetup_api.open_events(meetup_params)

  @events["results"].each do |event|
    meetup_attributes = {}
    meetup_attributes["utc_offset"] = event["utc_offset"]
    meetup_attributes["time"] = event["time"]
    meetup_attributes["event_url"] = event["event_url"]
    meetup_attributes["name"] = event["name"]
    meetup_attributes["description"] = event["description"]
    meetup_attributes["yes_rsvp_count"] = event["yes_rsvp_count"]
    meetup_attributes["status"] = event["status"]

    if event["venue"]
      meetup_attributes["venue_name"] = event["venue"]["name"]
      meetup_attributes["venue_city"] = event["venue"]["city"]
      meetup_attributes["venue_state"] = event["venue"]["state"]
      meetup_attributes["venue_zip"] = event["venue"]["zip"]
      meetup_attributes["venue_country"] = event["venue"]["country"]
      meetup_attributes["venue_address_1"] = event["venue"]["address_1"]
    end

    if event["group"]
      meetup_group_attributes = {}
      meetup_group_attributes["name"] = event["group"]["name"]
      meetup_group_attributes["group_url"] = "https://www.meetup.com/#{event["group"]["urlname"]}"

      meetup_group = MeetupGroup.find_or_create_by(meetup_group_attributes)

      meetup_attributes["group_id"] = meetup_group.id
    end

    Meetup.create(meetup_attributes)
  end

  #delete jobs here?
  Job.all.each do |job|
      job.destroy
  end

  #jobs
  craigslist_location = {"auburn" => "auburn", "bham" => "birmingham", "dothan" => "dothan", "shoals" => "florence / muscle shoals", "gadsden" => "gadsden-anniston", "huntsville" => "huntsville / decatur", "mobile" => "mobile", "montgomery" => "montgomery", "tuscaloosa" => "tuscaloosa", "anchorage" => "anchorage / mat-su", "fairbanks" => "fairbanks", "kenai" => "kenai peninsula", "juneau" => "southeast alaska", "flagstaff" => "flagstaff / sedona", "mohave" => "mohave county", "phoenix" => "phoenix", "prescott" => "prescott", "showlow" => "show low", "sierravista" => "sierra vista", "tucson" => "tucson", "yuma" => "yuma", "fayar" => "fayetteville ", "fortsmith" => "fort smith", "jonesboro" => "jonesboro", "littlerock" => "little rock", "texarkana" => "texarkana", "bakersfield" => "bakersfield", "chico" => "chico", "fresno" => "fresno / madera", "goldcountry" => "gold country", "hanford" => "hanford-corcoran", "humboldt" => "humboldt county", "imperial" => "imperial county", "inlandempire" => "inland empire", "losangeles" => "los angeles", "mendocino" => "mendocino county", "merced" => "merced", "modesto" => "modesto", "monterey" => "monterey bay", "orangecounty" => "orange county", "palmsprings" => "palm springs", "redding" => "redding", "sacramento" => "sacramento", "sandiego" => "san diego", "sfbay" => "san francisco bay area", "slo" => "san luis obispo", "santabarbara" => "santa barbara", "santamaria" => "santa maria", "siskiyou" => "siskiyou county", "stockton" => "stockton", "susanville" => "susanville", "ventura" => "ventura county", "visalia" => "visalia-tulare", "yubasutter" => "yuba-sutter", "boulder" => "boulder", "cosprings" => "colorado springs", "denver" => "denver", "eastco" => "eastern CO", "fortcollins" => "fort collins / north CO", "rockies" => "high rockies", "pueblo" => "pueblo", "westslope" => "western slope", "newlondon" => "eastern CT", "hartford" => "hartford", "newhaven" => "new haven", "nwct" => "northwest CT", "delaware" => "delaware", "washingtondc" => "washington", "miamibrw/" => "broward county", "daytona" => "daytona beach", "keys" => "florida keys", "fortlauderdale" => "fort lauderdale", "fortmyers" => "ft myers / SW florida", "gainesville" => "gainesville", "cfl" => "heartland florida", "jacksonville" => "jacksonville", "lakeland" => "lakeland", "miamimdc" => "miami / dade", "lakecity" => "north central FL", "ocala" => "ocala", "okaloosa" => "okaloosa / walton", "orlando" => "orlando", "panamacity" => "panama city", "pensacola" => "pensacola", "sarasota" => "sarasota-bradenton", "miami" => "south florida", "spacecoast" => "space coast", "staugustine" => "st augustine", "tallahassee" => "tallahassee", "tampa" => "tampa bay area", "treasure" => "treasure coast", "miamipbc" => "palm beach county", "albanyga" => "albany ", "athensga" => "athens", "atlanta" => "atlanta", "augusta" => "augusta", "brunswick" => "brunswick", "columbusga" => "columbus ", "macon" => "macon / warner robins", "nwga" => "northwest GA", "savannah" => "savannah / hinesville", "statesboro" => "statesboro", "valdosta" => "valdosta", "honolulu" => "hawaii", "boise" => "boise", "eastidaho" => "east idaho", "lewiston" => "lewiston / clarkston", "twinfalls" => "twin falls", "bn" => "bloomington-normal", "chambana" => "champaign urbana", "chicago" => "chicago", "decatur" => "decatur", "lasalle" => "la salle co", "mattoon" => "mattoon-charleston", "peoria" => "peoria", "rockford" => "rockford", "carbondale" => "southern illinois", "springfieldil" => "springfield ", "quincy" => "western IL", "bloomington" => "bloomington", "evansville" => "evansville", "fortwayne" => "fort wayne", "indianapolis" => "indianapolis", "kokomo" => "kokomo", "tippecanoe" => "lafayette / west lafayette", "muncie" => "muncie / anderson", "richmondin" => "richmond ", "southbend" => "south bend / michiana", "terrehaute" => "terre haute", "ames" => "ames", "cedarrapids" => "cedar rapids", "desmoines" => "des moines", "dubuque" => "dubuque", "fortdodge" => "fort dodge", "iowacity" => "iowa city", "masoncity" => "mason city", "quadcities" => "quad cities", "siouxcity" => "sioux city", "ottumwa" => "southeast IA", "waterloo" => "waterloo / cedar falls", "lawrence" => "lawrence", "ksu" => "manhattan", "nwks" => "northwest KS", "salina" => "salina", "seks" => "southeast KS", "swks" => "southwest KS", "topeka" => "topeka", "wichita" => "wichita", "bgky" => "bowling green", "eastky" => "eastern kentucky", "lexington" => "lexington", "louisville" => "louisville", "owensboro" => "owensboro", "westky" => "western KY", "batonrouge" => "baton rouge", "cenla" => "central louisiana", "houma" => "houma", "lafayette" => "lafayette", "lakecharles" => "lake charles", "monroe" => "monroe", "neworleans" => "new orleans", "shreveport" => "shreveport", "maine" => "maine", "annapolis" => "annapolis", "baltimore" => "baltimore", "easternshore" => "eastern shore", "frederick" => "frederick", "smd" => "southern maryland", "westmd" => "western maryland", "boston" => "boston", "capecod" => "cape cod / islands", "southcoast" => "south coast", "westernmass" => "western massachusetts", "worcester" => "worcester / central MA", "annarbor" => "ann arbor", "battlecreek" => "battle creek", "centralmich" => "central michigan", "detroit" => "detroit metro", "flint" => "flint", "grandrapids" => "grand rapids", "holland" => "holland", "jxn" => "jackson ", "kalamazoo" => "kalamazoo", "lansing" => "lansing", "monroemi" => "monroe ", "muskegon" => "muskegon", "nmi" => "northern michigan", "porthuron" => "port huron", "saginaw" => "saginaw-midland-baycity", "swmi" => "southwest michigan", "thumb" => "the thumb", "up" => "upper peninsula", "bemidji" => "bemidji", "brainerd" => "brainerd", "duluth" => "duluth / superior", "mankato" => "mankato", "minneapolis" => "minneapolis / st paul", "rmn" => "rochester ", "marshall" => "southwest MN", "stcloud" => "st cloud", "gulfport" => "gulfport / biloxi", "hattiesburg" => "hattiesburg", "jackson" => "jackson", "meridian" => "meridian", "northmiss" => "north mississippi", "natchez" => "southwest MS", "columbiamo" => "columbia / jeff city", "joplin" => "joplin", "kansascity" => "kansas city", "kirksville" => "kirksville", "loz" => "lake of the ozarks", "semo" => "southeast missouri", "springfield" => "springfield", "stjoseph" => "st joseph", "stlouis" => "st louis", "billings" => "billings", "bozeman" => "bozeman", "butte" => "butte", "greatfalls" => "great falls", "helena" => "helena", "kalispell" => "kalispell", "missoula" => "missoula", "montana" => "eastern montana", "grandisland" => "grand island", "lincoln" => "lincoln", "northplatte" => "north platte", "omaha" => "omaha / council bluffs", "scottsbluff" => "scottsbluff / panhandle", "elko" => "elko", "lasvegas" => "las vegas", "reno" => "reno / tahoe", "nh" => "new hampshire", "cnj" => "central NJ", "jerseyshore" => "jersey shore", "newjersey" => "north jersey", "southjersey" => "south jersey", "albuquerque" => "albuquerque", "clovis" => "clovis / portales", "farmington" => "farmington", "lascruces" => "las cruces", "roswell" => "roswell / carlsbad", "santafe" => "santa fe / taos", "albany" => "albany", "binghamton" => "binghamton", "buffalo" => "buffalo", "catskills" => "catskills", "chautauqua" => "chautauqua", "elmira" => "elmira-corning", "fingerlakes" => "finger lakes", "glensfalls" => "glens falls", "hudsonvalley" => "hudson valley", "ithaca" => "ithaca", "longisland" => "long island", "newyork" => "new york city", "oneonta" => "oneonta", "plattsburgh" => "plattsburgh-adirondacks", "potsdam" => "potsdam-canton-massena", "rochester" => "rochester", "syracuse" => "syracuse", "twintiers" => "twin tiers NY/PA", "utica" => "utica-rome-oneida", "watertown" => "watertown", "asheville" => "asheville", "boone" => "boone", "charlotte" => "charlotte", "eastnc" => "eastern NC", "fayetteville" => "fayetteville", "greensboro" => "greensboro", "hickory" => "hickory / lenoir", "onslow" => "jacksonville ", "outerbanks" => "outer banks", "raleigh" => "raleigh / durham / CH", "wilmington" => "wilmington", "winstonsalem" => "winston-salem", "bismarck" => "bismarck", "fargo" => "fargo / moorhead", "grandforks" => "grand forks", "nd" => "north dakota", "akroncanton" => "akron / canton", "ashtabula" => "ashtabula", "athensohio" => "athens ", "chillicothe" => "chillicothe", "cincinnati" => "cincinnati", "cleveland" => "cleveland", "columbus" => "columbus", "dayton" => "dayton / springfield", "limaohio" => "lima / findlay", "mansfield" => "mansfield", "sandusky" => "sandusky", "toledo" => "toledo", "tuscarawas" => "tuscarawas co", "youngstown" => "youngstown", "zanesville" => "zanesville / cambridge", "lawton" => "lawton", "enid" => "northwest OK", "oklahomacity" => "oklahoma city", "stillwater" => "stillwater", "tulsa" => "tulsa", "bend" => "bend", "corvallis" => "corvallis/albany", "eastoregon" => "east oregon", "eugene" => "eugene", "klamath" => "klamath falls", "medford" => "medford-ashland", "oregoncoast" => "oregon coast", "portland" => "portland", "roseburg" => "roseburg", "salem" => "salem", "altoona" => "altoona-johnstown", "chambersburg" => "cumberland valley", "erie" => "erie", "harrisburg" => "harrisburg", "lancaster" => "lancaster", "allentown" => "lehigh valley", "meadville" => "meadville", "philadelphia" => "philadelphia", "pittsburgh" => "pittsburgh", "poconos" => "poconos", "reading" => "reading", "scranton" => "scranton / wilkes-barre", "pennstate" => "state college", "williamsport" => "williamsport", "york" => "york", "providence" => "rhode island", "charleston" => "charleston", "columbia" => "columbia", "florencesc" => "florence", "greenville" => "greenville / upstate", "hiltonhead" => "hilton head", "myrtlebeach" => "myrtle beach", "nesd" => "northeast SD", "csd" => "pierre / central SD", "rapidcity" => "rapid city / west SD", "siouxfalls" => "sioux falls / SE SD", "sd" => "south dakota", "chattanooga" => "chattanooga", "clarksville" => "clarksville", "cookeville" => "cookeville", "jacksontn" => "jackson  ", "knoxville" => "knoxville", "memphis" => "memphis", "nashville" => "nashville", "tricities" => "tri-cities", "abilene" => "abilene", "amarillo" => "amarillo", "austin" => "austin", "beaumont" => "beaumont / port arthur", "brownsville" => "brownsville", "collegestation" => "college station", "corpuschristi" => "corpus christi", "dallas" => "dallas / fort worth", "nacogdoches" => "deep east texas", "delrio" => "del rio / eagle pass", "elpaso" => "el paso", "galveston" => "galveston", "houston" => "houston", "killeen" => "killeen / temple / ft hood", "laredo" => "laredo", "lubbock" => "lubbock", "mcallen" => "mcallen / edinburg", "odessa" => "odessa / midland", "sanangelo" => "san angelo", "sanantonio" => "san antonio", "sanmarcos" => "san marcos", "bigbend" => "southwest TX", "texoma" => "texoma", "easttexas" => "tyler / east TX", "victoriatx" => "victoria ", "waco" => "waco", "wichitafalls" => "wichita falls", "logan" => "logan", "ogden" => "ogden-clearfield", "provo" => "provo / orem", "saltlakecity" => "salt lake city", "stgeorge" => "st george", "vermont" => "vermont", "charlottesville" => "charlottesville", "danville" => "danville", "fredericksburg" => "fredericksburg", "norfolk" => "hampton roads", "harrisonburg" => "harrisonburg", "lynchburg" => "lynchburg", "blacksburg" => "new river valley", "richmond" => "richmond", "roanoke" => "roanoke", "swva" => "southwest VA", "winchester" => "winchester", "bellingham" => "bellingham", "kpr" => "kennewick-pasco-richland", "moseslake" => "moses lake", "olympic" => "olympic peninsula", "pullman" => "pullman / moscow", "seattle" => "seattle-tacoma", "skagit" => "skagit / island / SJI", "spokane" => "spokane / coeur d'alene", "wenatchee" => "wenatchee", "yakima" => "yakima", "charlestonwv" => "charleston ", "martinsburg" => "eastern panhandle", "huntington" => "huntington-ashland", "morgantown" => "morgantown", "wheeling" => "northern panhandle", "parkersburg" => "parkersburg-marietta", "swv" => "southern WV", "wv" => "west virginia (old)", "appleton" => "appleton-oshkosh-FDL", "eauclaire" => "eau claire", "greenbay" => "green bay", "janesville" => "janesville", "racine" => "kenosha-racine", "lacrosse" => "la crosse", "madison" => "madison", "milwaukee" => "milwaukee", "northernwi" => "northern WI", "sheboygan" => "sheboygan", "wausau" => "wausau", "wyoming" => "wyoming", "micronesia" => "guam-micronesia", "puertorico" => "puerto rico", "virgin" => "U.S. virgin islands"}

  languages = params[:item].inspect
  location = params.fetch("location")
  distance = params.fetch("distance")
  level = params.fetch("level")

  city = craigslist_location[location]
  query = "javascript+developer"
  @link = "https://www.indeed.com/jobs?q=#{query}&l=#{city}"
  Job.scrape_indeed(@link)

  @link = "https://#{city}.craigslist.org/search/jjj?query=#{query}&s=0&sort=rel"
  Job.scrape_craigslist(@link)

  @meetups = Meetup.all
  @jobs = Job.all
  erb(:home)
end

get('/meetups/:meetup_id') do
  @meetup = Meetup.find(params[:meetup_id])
  erb(:meetup_detail)
end

get('/jobs/:job_id') do
  erb(:job_detail)
end

get("/scrape") do
  city = "portland"
  state = ("or").upcase
  query = "javascript+developer"
  # @link = "https://www.indeed.com/jobs?q=#{query}&l=#{city}%2C+#{state}"
  # Job.scrape_indeed(@link)

  @link = "https://#{city}.craigslist.org/search/jjj?query=#{query}&s=0&sort=rel"
  Job.scrape_craigslist(@link)
  erb(:scrape)
end
