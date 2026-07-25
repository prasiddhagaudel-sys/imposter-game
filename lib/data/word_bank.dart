class WordEntry {
  final String word;
  final List<String> hints;
  const WordEntry(this.word, this.hints);
}

const Map<String, List<WordEntry>> wordBank = {
  // ─── 1. FOOD & DRINKS ───────────────────────────────────────────────────
  'Food & Drinks': [
    WordEntry('Chai / Tea', [
      'Thermal infusion', 'Morning ritual', 'Brown liquid', 'Boiling patience', 'Leafy essence',
      'Daily rhythm', 'Strained clarity', 'Shared silence', 'Refueling habit', 'Steaming comfort',
      'Warmth in hand', 'Caffeine pulse', 'Aromatic steam', 'Social potion', 'Break time habit',
      'Stirred sugar', 'Subtle spice', 'Dawn necessity', 'Quiet gathering', 'Hot beverage',
      'Earthen cup', 'Comforting sip', 'Daily starter', 'Liquid warmth', 'Kitchen vessel'
    ]),
    WordEntry('Momo / Dumpling', [
      'Concealed interior', 'Folded envelope', 'Steamed pocket', 'Soft wrapper', 'Hidden filling',
      'Spicy companion', 'Bite-sized bundle', 'Bamboo origin', 'Moist texture', 'Wrapped savory',
      'Street side craving', 'Savory pouch', 'Dough enclosure', 'Warm center', 'Dipping partner',
      'Delicate fold', 'Dough shell', 'Minced core', 'Juicy surprise', 'Evening snack',
      'Flour bundle', 'Small parcel', 'Steam cooked', 'Pinch edge', 'Savory bite'
    ]),
    WordEntry('Samosa', [
      'Geometrical crust', 'Golden pyramid', 'Deep fried shell', 'Stuffed corner', 'Crispy triangle',
      'Savory core', 'Oil bath', 'Maida architecture', 'Pastry corner', 'Chutney companion',
      'Hot interior', 'Spiced filling', 'Crispy edge', 'Tea partner', 'Street counter',
      'Flaky exterior', 'Break snack', 'Traditional shape', 'Crunchy corner', 'Heated center',
      'Fried pocket', 'Savory shape', 'Crushed crust', 'Pastry shell', 'Spicy pyramid'
    ]),
    WordEntry('Pani Puri', [
      'Fragile sphere', 'Hollow crunch', 'Liquid explosion', 'Single mouthful', 'Tangy burst',
      'Cold water core', 'Delicate shell', 'Counter patience', 'Street queue', 'Chilli rush',
      'Swallowed whole', 'Flavor explosion', 'Crispy dome', 'Spiced liquid', 'Instant swallow',
      'Filled hole', 'Paper plate', 'Mint tang', 'Crispy orb', 'Quick bite',
      'Street obsession', 'Popping crunch', 'Water burst', 'Hollow globe', 'Snack burst'
    ]),
    WordEntry('Biryani', [
      'Layered creation', 'Aromatic grain', 'Dum patience', 'Royal mixture', 'Spiced rice',
      'Slow simmer', 'Saffron hue', 'Rich ensemble', 'Festive platter', 'Flavored steam',
      'Clay pot seal', 'Weekend feast', 'Marinated layers', 'Grain harmony', 'Handi vessel',
      'Grand meal', 'Spiced aroma', 'Festive table', 'Rich texture', 'Layered dish',
      'Flavorful rice', 'Special occasion', 'Ghee aroma', 'Savory feast', 'Pot creation'
    ]),
    WordEntry('Jalebi', [
      'Golden coil', 'Crispy spiral', 'Syrup dip', 'Sticky loop', 'Sweet spiral',
      'Deep oil loop', 'Orange glow', 'Juicy crunch', 'Melt in mouth', 'Festive loop',
      'Hot off oil', 'Breakfast sweet', 'Syrup soaked', 'Coiled batter', 'Sugar rush',
      'Sweet rings', 'Crispy weave', 'Desi dessert', 'Confectionery loop', 'Halwai craft',
      'Sugar coat', 'Circular sweet', 'Golden web', 'Crispy sweet', 'Syrup drip'
    ]),
    WordEntry('Lassi', [
      'Thick emulsion', 'Chilled yogurt', 'Creamy top', 'Earthen glass', 'Cooling potion',
      'Summer savior', 'Churned curd', 'Heavy sip', 'Rich beverage', 'Brass tumbler',
      'Sweet or salted', 'Refreshing drink', 'Dairy blend', 'Creamy texture', 'Afternoon glass',
      'Whipped milk', 'Cold comfort', 'Nutritious sip', 'Tall glass', 'Smooth texture',
      'Churned blend', 'Gut cooler', 'Thick drink', 'Chilled glass', 'Refreshing sip'
    ]),
    WordEntry('Dal Bhat', [
      'National staple', 'Lentil soup', 'Steamed grain', 'Comfort thali', 'Daily balance',
      'Everyday meal', 'Brass platter', 'Home comfort', 'Energy source', 'Two times daily',
      'Simple thali', 'Nourishing bowl', 'Traditional meal', 'Hand mixing', 'Warm plate',
      'Daily fuel', 'Mother\'s kitchen', 'Ghee drizzle', 'Subtle spices', 'Balanced plate',
      'Paddy and legume', 'Essential dish', 'Clean eating', 'Wholesome fuel', 'Homely meal'
    ]),
  ],

  // ─── 2. CULTURE & FESTIVALS ─────────────────────────────────────────────
  'Culture & Festivals': [
    WordEntry('Diwali / Tihar', [
      'Night illumination', 'Earthen flame', 'Doorstep pattern', 'Triumph of light', 'Festive glow',
      'Family reunion', 'Card games evening', 'Sweet exchange', 'Floral garland', 'New attire',
      'Bright window', 'Puja ritual', 'Goddess welcome', 'Illuminated night', 'Festive week',
      'Sparkling lights', 'Cleaned home', 'Joyful spirit', 'Oil lamp', 'Festive season',
      'Celebration week', 'Golden glow', 'Luminous night', 'Marigold decor', 'Light over dark'
    ]),
    WordEntry('Holi', [
      'Prismatic powder', 'Spring arrival', 'Stained clothes', 'Playful battle', 'Water splash',
      'Color throw', 'White shirt ruined', 'Festive madness', 'Joyous crowd', 'Community dance',
      'Color wash off', 'March celebration', 'Festive song', 'Playful chaos', 'Face splash',
      'Open air fun', 'Colored hands', 'Spring festival', 'Laughter noise', 'Vibrant crowd',
      'Bucket splash', 'Colorful face', 'Festive energy', 'Joyful mess', 'Color rain'
    ]),
    WordEntry('Bollywood', [
      'Silver screen', 'Dramatic story', 'Musical sequence', 'Star glamour', 'Box office',
      'Mass entertainment', 'Choreographed dance', 'Pop culture', 'Intermission break', 'Melodrama',
      'Fan frenzy', 'Cinema hall', 'Heroic drama', 'Playback melody', 'Blockbuster',
      'Film poster', 'Grand production', 'Screen fame', 'Cinematic universe', 'Star power',
      'Movie magic', 'Film industry', 'Cultural icon', 'Romantic action', 'Screen idol'
    ]),
    WordEntry('Auto Rickshaw', [
      'Three wheeled icon', 'Yellow green canopy', 'Meter counter', 'Engine sputter', 'Narrow weaver',
      'Street commute', 'Short distance', 'Fare negotiation', 'Urban transport', 'Open sides',
      'Daily ride', 'Traffic navigator', 'Driver mirror', 'Street taxi', 'City shuttle',
      'Commuter vehicle', 'Coin fare', 'Black hood', 'Urban mover', 'Sputtering ride',
      'Three wheel taxi', 'Road commuter', 'Street transport', 'City ride', 'Quick transit'
    ]),
    WordEntry('Cricket', [
      'Gentleman\'s game', 'Eleven vs eleven', 'Pitch battle', 'Wooden bat', 'Leather sphere',
      'Boundary hit', 'Umpire signal', 'Stadium roar', 'National passion', 'Wicket fall',
      'Over count', 'Gully match', 'Match day', 'Commentary mic', 'Toss of coin',
      'Tournament pressure', 'Catch out', 'Scoreboard chase', 'Cheering fans', 'Pad and glove',
      'Strategic field', 'Bowling runup', 'Championship match', 'Fielding effort', 'Batting lineup'
    ]),
    WordEntry('Shaadi / Marriage', [
      'Union ritual', 'Sacred altar', 'Seven promises', 'Procession band', 'Festive venue',
      'Heavy jewelry', 'Bridal red', 'Henna pattern', 'Late night vows', 'Grand buffet',
      'Relative gathering', 'Family milestone', 'Gold exchange', 'Emotional farewell', 'Decorated stage',
      'Celebration night', 'Wedding card', 'Traditional attire', 'Life commitment', 'Cultural union',
      'Music ceremony', 'Festive gathering', 'Bridal entry', 'Grand event', 'Sacred knot'
    ]),
    WordEntry('Monsoon Rain', [
      'Petrichor scent', 'Dark sky', 'Heavy downpour', 'Paper vessel', 'Umbrella opened',
      'Waterlogged street', 'Cool breeze', 'Puddle splash', 'Thunder rumble', 'Raincoat season',
      'Greenery refresh', 'Overcast day', 'Rainy afternoon', 'Drizzling drops', 'Lightning streak',
      'Stormy weather', 'Earth wash', 'Fresh atmosphere', 'Farmer\'s joy', 'Cozy shelter',
      'Rainfall wave', 'Overcast sky', 'Watery streets', 'Nature wash', 'Subtropical rain'
    ]),
    WordEntry('Jugaad', [
      'Frugal fix', 'Unconventional hack', 'Creative solution', 'Resourceful trick', 'Clever patch',
      'Problem solving', 'Saving money', 'Make-do tool', 'Improvised fix', 'Out of box',
      'Local wisdom', 'Quick repair', 'No wastage', 'Practical mind', 'Workaround',
      'Clever shortcut', 'Innovative patch', 'Efficiency hack', 'Smart alternative', 'Frugal mind',
      'Creative mind', 'Custom fix', 'Local innovation', 'Resourceful hack', 'Clever solution'
    ]),
  ],

  // ─── 3. EVERYDAY OBJECTS ────────────────────────────────────────────────
  'Everyday Objects': [
    WordEntry('Pressure Cooker', [
      'Whistle release', 'Steam valve', 'Sealed pot', 'Kitchen appliance', 'Hissing sound',
      'Stovetop container', 'Faster boiling', 'Mother\'s signal', 'Rubber gasket', 'High heat pot',
      'Lentil cooker', 'Countertop vessel', 'Heavy lid', 'Pressurized steam', 'Kitchen essential',
      'Metal vessel', 'Boiling noise', 'Dinner maker', 'Steam pressure', 'Safety valve',
      'Sealed vessel', 'Stove cooker', 'Kitchen tool', 'Rapid cooking', 'Heavy pot'
    ]),
    WordEntry('Chappal / Slippers', [
      'Indoor footwear', 'Rubber sole', 'Toe strap', 'House slipper', 'Doorstep item',
      'Casual walk', 'Easy slip on', 'Flat footwear', 'Mom\'s weapon', 'Daily footwear',
      'Bathroom footwear', 'Simple sole', 'Walking comfort', 'Floor walker', 'Shoe rack item',
      'Pair of two', 'Casual slipper', 'Foot protector', 'Lightweight pair', 'Home footwear',
      'Rubber sandal', 'Simple slipper', 'Doorstep left', 'Indoor sandal', 'Casual sole'
    ]),
    WordEntry('Steel Glass', [
      'Metallic vessel', 'Stainless container', 'Unbreakable glass', 'Dhaba tumbler', 'Kitchen shelf',
      'Cold water sweat', 'No handle cup', 'Shiny utensil', 'Silver tumbler', 'Hydration vessel',
      'Utensil rack', 'Everyday drinkware', 'Durable metal', 'Dinner table item', 'Simple cylinder',
      'Stackable cup', 'Indian kitchen item', 'Metallic sound', 'Household vessel', 'Water glass',
      'Metal container', 'Solid tumbler', 'Utensil item', 'Daily vessel', 'Silver cup'
    ]),
    WordEntry('Carrom Board', [
      'Square wooden game', 'Corner pockets', 'Powdered surface', 'Finger flick', 'Striker puck',
      'Black white pawns', 'Red queen coin', 'Flick angle', 'Smooth gliding', 'Indoor pass time',
      'Veranda board', 'Recreation game', 'Tabletop match', 'Pocketing coins', 'Covering queen',
      'Center circle', 'Family board', 'Flick mechanics', 'Wooden frame', 'Classic board',
      'Pawn layout', 'Indoor match', 'Smooth board', 'Flick control', 'Board game'
    ]),
    WordEntry('Ludo Board', [
      'Four colored grid', 'Dice roller', 'Token movement', 'Home center', 'Board game app',
      'Rolling a six', 'Cutting opponent', 'Casual gaming', 'Family quarrel', 'Square track',
      'Safe star spots', 'Token entry', 'Turn taking', 'Luck of dice', 'Four color track',
      'Tabletop fun', 'Pass time game', 'Count of steps', 'Token chase', 'Board match',
      'Game of luck', 'Classic grid', 'Dice game', 'Four player match', 'Board grid'
    ]),
    WordEntry('Matchbox / Machis', [
      'Cardboard box', 'Striking strip', 'Phosphorus tip', 'Wooden stick', 'Spark starter',
      'Flame maker', 'Incense lighter', 'Kitchen drawer item', 'Small box', 'Friction spark',
      'Lighting candle', 'Smoke puff', 'Burnt wood smell', 'Fire hazard', 'Utility box',
      'Pocket size item', 'Lighting stove', 'Matchstick holder', 'Small flame', 'Flame box',
      'Fire starter', 'Small matches', 'Friction box', 'Lighting fire', 'Essential box'
    ]),
    WordEntry('Broom / Jhadu', [
      'Sweeping bristles', 'Floor cleaner', 'Dust collector', 'Morning chore', 'Coconut fibers',
      'Dustpan partner', 'Housekeeping tool', 'Corner sweeper', 'Floor maintenance', 'Daily cleaning',
      'Dust removal', 'Indoor sweeper', 'Long handle', 'Cleanliness tool', 'Trash sweeper',
      'Housework essential', 'Floor tool', 'Straw bristles', 'Morning routine', 'Sweeping motion',
      'Floor sweeper', 'Dust tool', 'Cleaning broom', 'Home maintenance', 'Sweeping tool'
    ]),
    WordEntry('Umbrella', [
      'Canopy shield', 'Waterproof fabric', 'Opens and closes', 'Metal ribs frame', 'Rain protector',
      'Sunshade canopy', 'Folding frame', 'Hooked handle', 'Monsoon partner', 'Drying in balcony',
      'Portable shade', 'Handheld shield', 'Weather gear', 'Drip drops', 'Storm companion',
      'Wind resistance', 'Outdoor travel', 'Sun protection', 'Pocket folding', 'Rainy day gear',
      'Canopy shield', 'Rain gear', 'Handheld canopy', 'Weather shield', 'Folding shield'
    ]),
  ],

  // ─── 4. PLACES & TRAVEL ─────────────────────────────────────────────────
  'Places & Travel': [
    WordEntry('Airport', [
      'Flight hub', 'Runway tarmac', 'Boarding gate', 'Security line', 'Luggage trolley',
      'Control tower', 'Passport check', 'Duty free shop', 'Flight announcement', 'Baggage belt',
      'Terminal building', 'Travel hub', 'Air travel', 'Pilot crew', 'Check in counter',
      'Customs clearance', 'Waiting lounge', 'Flight departure', 'Global gateway', 'Jet engines',
      'Aviation hub', 'Travel gateway', 'Flight terminal', 'Aerial transport', 'Sky gateway'
    ]),
    WordEntry('Hospital', [
      'Healing center', 'Stethoscope doctors', 'Emergency ward', 'White coats', 'Quiet corridors',
      'Patient beds', 'Medicine smell', 'Operating theater', 'Intensive care', 'Ambulance siren',
      'Health checkup', 'Syringe needle', 'Drip bottle', 'Medical charts', 'Healing sanctuary',
      'Surgical mask', 'Recovery room', 'Pharmacy section', 'Vital monitors', 'Clinical care',
      'Healthcare center', 'Medical facility', 'Caregiver hub', 'Health recovery', 'Clinical ward'
    ]),
    WordEntry('Railway Station', [
      'Iron tracks', 'Platform numbers', 'Locomotive engine', 'Passenger train', 'Ticket counter',
      'Whistle sound', 'Track switch', 'Overhead bridge', 'Waiting hall', 'Train announcement',
      'Public transport', 'Station master', 'Metal rails', 'Train arrival', 'Travel hub',
      'Platform clock', 'Speeding coaches', 'Station platform', 'Long journey', 'Rail network',
      'Track junction', 'Rail transport', 'Train junction', 'Platform queue', 'Rail station'
    ]),
    WordEntry('School', [
      'Learning building', 'Classroom desks', 'Blackboard', 'Teacher lecture', 'School uniform',
      'Bell ringing', 'Recess break', 'Homework task', 'Morning assembly', 'Textbook notebook',
      'Report card', 'Principal office', 'Playground', 'Attendance call', 'Pencil box',
      'Education center', 'Classmates', 'Subject teacher', 'Childhood spot', 'Study hall',
      'Academic hub', 'Student hall', 'Learning center', 'Classroom hall', 'Education spot'
    ]),
    WordEntry('Cinema Hall', [
      'Projection screen', 'Popcorn tub', 'Recliner seats', 'Intermission break', 'Surround sound',
      'Dark auditorium', 'Movie trailer', 'Box office', 'Big screen', 'Housefull sign',
      'Movie fans', 'Film show', 'Theatre snack', '3D glasses', 'Auditorium hall',
      'Screening room', 'Film venue', 'Show timing', 'Cinematic hall', 'Movie theater',
      'Film screening', 'Screen hall', 'Movie venue', 'Entertainment hall', 'Show hall'
    ]),
    WordEntry('Local Bazaar', [
      'Crowded alleys', 'Vendor stalls', 'Bargaining noise', 'Vegetable carts', 'Footwear shops',
      'Street vendors', 'Shopping bags', 'Hustle and bustle', 'Buying and selling', 'Narrow market',
      'Cash payment', 'Evening crowd', 'Product displays', 'Commercial hub', 'Shoppers walking',
      'Cloth market', 'Storefronts', 'City market', 'Street shopping', 'Local trade',
      'Marketplace', 'Vendor street', 'Trade market', 'Shopping lane', 'City bazaar'
    ]),
    WordEntry('Temple / Mandir', [
      'Sacred sanctuary', 'Incense smoke', 'Brass bell sound', 'Floral offerings', 'Deity shrine',
      'Priest puja', 'Chanting mantras', 'Peaceful energy', 'Oil lamp glow', 'Barefoot walk',
      'Spiritual spire', 'Holy place', 'Devotee queue', 'Circumambulation', 'Divine atmosphere',
      'Faith center', 'Spiritual spot', 'Prayer hall', 'Sacred shrine', 'Devotional spot',
      'Spiritual sanctuary', 'Worship shrine', 'Holy sanctuary', 'Faith shrine', 'Divine place'
    ]),
    WordEntry('Trekking Trail', [
      'Mountain path', 'Backpack hiking', 'Winding trail', 'Steep climb', 'Walking stick',
      'High altitude', 'Fresh air', 'Tea house lodge', 'Pine valley', 'Scenic heights',
      'Map and compass', 'Trekker group', 'Suspension bridge', 'Nature hike', 'Camping tent',
      'Rocky terrain', 'Summit goal', 'Outdoors trail', 'Himalayan path', 'Adventure walk',
      'Hiking route', 'Alpine trail', 'Mountain route', 'Summit trail', 'Nature path'
    ]),
  ],

  // ─── 5. ANIMALS & WILDLIFE ──────────────────────────────────────────────
  'Animals': [
    WordEntry('Dog', [
      'Loyal companion', 'Tail wagging', 'Barking sound', 'Leash walk', 'Pet collar',
      'Fetch ball', 'Canine friend', 'Guard animal', 'Four legs', 'Fur coat',
      'Puppy eyes', 'Paw prints', 'House pet', 'Faithful friend', 'Sniffing nose',
      'Bone chewer', 'Pet dog', 'Best friend', 'Barking guard', 'Canine pet',
      'Loyal friend', 'Four legged pet', 'Furry companion', 'Domestic dog', 'Pet companion'
    ]),
    WordEntry('Cat', [
      'Feline companion', 'Purring sound', 'Meow call', 'Whiskers face', 'Soft paws',
      'Milk drinker', 'Mouse hunter', 'Agile climber', 'Night eyes', 'Furry pet',
      'Tail flick', 'Scratching post', 'Lazy napper', 'Pouncing predator', 'House cat',
      'Feline pet', 'Soft fur', 'Curled sleeping', 'Silent walker', 'Pet feline',
      'Whiskered pet', 'Agile pet', 'Feline hunter', 'Domestic cat', 'Quiet pet'
    ]),
    WordEntry('Elephant', [
      'Giant mammal', 'Long trunk', 'Ivory tusks', 'Large ears', 'Heavy footsteps',
      'Gray skin', 'Jungle giant', 'Water spraying', 'Herbivore giant', 'Wild elephant',
      'Strong trunk', 'Gentle giant', 'Herd leader', 'Forest giant', 'Majestic beast',
      'Thick hide', 'Forest animal', 'Big ears', 'Wild giant', 'Huge mammal',
      'Trunked giant', 'Big mammal', 'Jungle beast', 'Forest mammal', 'Large beast'
    ]),
    WordEntry('Tiger', [
      'Striped predator', 'Roaring predator', 'Jungle king', 'Wild cat', 'Sharp claws',
      'Camouflage stripes', 'Apex hunter', 'Carnivore feline', 'National animal', 'Prowling hunter',
      'Wild tiger', 'Forest hunter', 'Fierce beast', 'Big cat', 'Jungle predator',
      'Orange black stripes', 'Stalking prey', 'Wild beast', 'Majestic predator', 'Forest cat',
      'Striped feline', 'Apex predator', 'Jungle hunter', 'Wild predator', 'Big feline'
    ]),
    WordEntry('Monkey', [
      'Tree climber', 'Playful primate', 'Long tail', 'Banana lover', 'Branch swinging',
      'Chattering sound', 'Troop member', 'Curious animal', 'Roof jumper', 'Cheeky mammal',
      'Agile jumper', 'Forest primate', 'Clever animal', 'Branch jumper', 'Wild monkey',
      'Primate animal', 'Tree jumper', 'Playful trickster', 'Jungle primate', 'Agile climber',
      'Tree primate', 'Swinging mammal', 'Wild primate', 'Playful animal', 'Forest climber'
    ]),
    WordEntry('Cow', [
      'Sacred animal', 'Milk provider', 'Moo sound', 'Grass grazing', 'Gentle bovine',
      'Horns and hooves', 'Farm animal', 'Calf mother', 'Pasture grazer', 'Dairy giver',
      'Domestic bovine', 'Street dweller', 'Chewing cud', 'Barn resident', 'Peaceful animal',
      'Milk animal', 'Holy cow', 'Bovine pet', 'Farm mammal', 'Gentle grazer',
      'Dairy mammal', 'Grazing animal', 'Farm bovine', 'Domestic grazer', 'Gentle beast'
    ]),
    WordEntry('Cobra', [
      'Venomous serpent', 'Hooded snake', 'Hissing sound', 'Fanged reptile', 'Scaly body',
      'Lethal strike', 'Serpent coil', 'Danger reptile', 'Snake charmer', 'Wild reptile',
      'Venomous bite', 'Slithering movement', 'Forked tongue', 'Reptile hunter', 'King cobra',
      'Hooded reptile', 'Deadly serpent', 'Reptile snake', 'Venomous strike', 'Forest serpent',
      'Scaly serpent', 'Deadly reptile', 'Hissing serpent', 'Venomous snake', 'Wild serpent'
    ]),
    WordEntry('Peacock', [
      'National bird', 'Feather plume', 'Colorful tail', 'Rain dancer', 'Blue neck',
      'Crown crest', 'Majestic bird', 'Loud call', 'Spread feathers', 'Beautiful plume',
      'Royal bird', 'Forest bird', 'Colorful feathers', 'Dancing bird', 'Graceful avian',
      'Feather fan', 'Vibrant plumage', 'Wild bird', 'Blue bird', 'Prideful bird',
      'Plumed bird', 'Feathered avian', 'Dancing avian', 'Majestic plume', 'Royal avian'
    ]),
  ],

  // ─── 6. MOVIES & TV ─────────────────────────────────────────────────────
  'Movies & TV': [
    WordEntry('Bollywood Film', [
      'Silver screen drama', 'Masala story', 'Song sequence', 'Box office hit', 'Cinema feature',
      'Intermission break', 'Melodrama plot', 'Star cast', 'Choreographed dance', 'Romantic action',
      'Cinema release', 'Film production', 'Heroic lead', 'Musical feature', 'Blockbuster film',
      'Screen story', 'Pop culture movie', 'Film poster', 'Theater show', 'Cinematic drama',
      'Movie release', 'Bollywood feature', 'Silver screen show', 'Film entertainment', 'Cinematic film'
    ]),
    WordEntry('Actor / Hero', [
      'Screen star', 'Lead performer', 'Movie icon', 'Celebrity fame', 'Dialogue delivery',
      'Acting talent', 'Film hero', 'Fan favorite', 'Autograph sign', 'Paprazzi target',
      'Silver screen star', 'Role portrayal', 'Award winner', 'Cinema actor', 'Star performer',
      'Film star', 'Screen idol', 'Lead actor', 'Cinema star', 'Action hero',
      'Performing star', 'Screen icon', 'Film celebrity', 'Movie star', 'Lead performer'
    ]),
    WordEntry('Popcorn', [
      'Theater snack', 'Popped corn', 'Butter flavor', 'Tub of snack', 'Cinema munchie',
      'Crunchy bite', 'Salted snack', 'Movie companion', 'Snack counter', 'Popping kernels',
      'Warm snack', 'Bucket of popcorn', 'Cinema food', 'Theater crunch', 'Movie snack',
      'Fluffy bite', 'Butter popcorn', 'Snack tub', 'Movie night food', 'Crispy snack',
      'Popped snack', 'Cinema tub', 'Theater munch', 'Snack bucket', 'Movie corn'
    ]),
    WordEntry('Director', [
      'Film maker', 'Camera caller', 'Action cut caller', 'Visionary director', 'Set leader',
      'Script interpreter', 'Behind the lens', 'Film guide', 'Movie director', 'Creative mind',
      'Director chair', 'Scene storyteller', 'Cinematic guide', 'Film captain', 'Shooting director',
      'Helmer of film', 'Behind camera', 'Visionary filmmaker', 'Film lead', 'Movie maker',
      'Filmmaker', 'Set captain', 'Scene master', 'Creative director', 'Lens director'
    ]),
    WordEntry('Television / TV', [
      'Living room screen', 'Channel surfer', 'Remote control', 'Broadcast screen', 'Home display',
      'Serial show', 'News broadcast', 'Prime time show', 'Flat display', 'Cable box',
      'Entertainment box', 'TV screen', 'Family viewing', 'Monitor screen', 'Daily serial',
      'Television set', 'Living room TV', 'Home screen', 'Broadcast TV', 'TV display',
      'Display screen', 'Television screen', 'Home entertainment', 'TV box', 'Screen display'
    ]),
    WordEntry('Web Series', [
      'Streaming show', 'OTT platform', 'Episode binge', 'Season release', 'Digital series',
      'Binge watching', 'Streaming platform', 'Online series', 'Digital show', 'Multi episode',
      'Season finale', 'Episode drop', 'Web drama', 'OTT show', 'Digital drama',
      'Streaming series', 'Binge show', 'Online drama', 'Mobile streaming', 'Web show',
      'Digital stream', 'OTT series', 'Episode series', 'Web stream', 'Streaming entertainment'
    ]),
    WordEntry('Cricket Match TV', [
      'Live broadcast', 'Match screening', 'Sports channel', 'Live commentary', 'Scoreboard screen',
      'Stadium feed', 'Cricket telecast', 'Living room crowd', 'Match viewing', 'Live coverage',
      'Sports telecast', 'Match day TV', 'Cricket stream', 'Live sports', 'Game broadcast',
      'Over by over screen', 'Cheering fans TV', 'Match stream', 'Sports broadcast', 'Live match',
      'Match coverage', 'Cricket broadcast', 'Live sports TV', 'Match telecast', 'Game stream'
    ]),
    WordEntry('Comedy Show', [
      'Laughter show', 'Standup comedy', 'Joke delivery', 'Humorous acts', 'Comic performers',
      'Laugh track', 'Punchline joke', 'Comedian stage', 'Funny sketches', 'Entertainment show',
      'Laughter therapy', 'Gag show', 'Comic timing', 'Humor show', 'Comedy night',
      'Funny show', 'Laughter noise', 'Standup show', 'Comedy act', 'Humorous show',
      'Comic act', 'Laughter program', 'Funny act', 'Humor performance', 'Comedy program'
    ]),
  ],

  // ─── 7. SPORTS & GAMES ──────────────────────────────────────────────────
  'Sports': [
    WordEntry('Cricket', [
      'Pitch battle', 'Bat and ball', 'Wicket stumps', 'Eleven team', 'Boundary hit',
      'Over count', 'Umpire signal', 'Stadium roar', 'Gentleman sport', 'LBW decision',
      'Leather sphere', 'Wooden bat', 'Match day', 'Tournament play', 'Gully match',
      'National game', 'Commentary mic', 'Toss of coin', 'Batting bowling', 'Championship game',
      'Pitch sport', 'Fielding sport', 'Wicket game', 'Batting sport', 'Cricket match'
    ]),
    WordEntry('Football / Soccer', [
      'Goal post', 'Black white ball', 'Ninety minutes', 'Grass pitch', 'Penalty kick',
      'Red yellow card', 'Referees whistle', 'Corner kick', 'Dribble skills', 'Eleven players',
      'Goalkeeper saves', 'Stadium chant', 'World Cup', 'League match', 'Pass and shoot',
      'Soccer match', 'Football pitch', 'Striker goal', 'Team sport', 'Pitch match',
      'Ball game', 'Goal sport', 'Kick sport', 'Football game', 'Soccer sport'
    ]),
    WordEntry('Badminton', [
      'Feather shuttle', 'Racket sport', 'Net barrier', 'Smash hit', 'Court boundary',
      'Lightweight racket', 'Shuttlecock flight', 'Indoor court', 'Service serve', 'Rally exchange',
      'Badminton match', 'Fast rally', 'Court sport', 'Net play', 'Drop shot',
      'Feather bird', 'Racket game', 'Doubles singles', 'Indoor sport', 'Badminton court',
      'Shuttle game', 'Racket match', 'Net sport', 'Court match', 'Badminton play'
    ]),
    WordEntry('Kabaddi', [
      'Raider chant', 'Mat arena', 'Body tackle', 'Touch point', 'Super raid',
      'Breath control', 'Seven defense', 'Physical sport', 'Mat court', 'Ankle hold',
      'Desi sport', 'Raider entry', 'Defense line', 'Pro league', 'Physical wrestling',
      'Tag and run', 'Kabaddi court', 'Raider whistle', 'Combative sport', 'Team wrestling',
      'Raid sport', 'Tag sport', 'Mat match', 'Kabaddi match', 'Physical game'
    ]),
    WordEntry('Chess', [
      'Mind strategy', '64 squares', 'Black white pieces', 'King checkmate', 'Queen power',
      'Knight jump', 'Rook pawn', 'Mental battle', 'Tactical board', 'Clock timer',
      'Chessboard match', 'Grandmaster mind', 'Calculated move', 'Piece capture', 'Strategic game',
      'Board strategy', 'Mind match', 'Chess pieces', 'Checkmate win', 'Tactical game',
      'Square board', 'Piece strategy', 'Mental sport', 'Chess match', 'Strategic board'
    ]),
    WordEntry('Volleyball', [
      'High net', 'Spike hit', 'Six players', 'Court service', 'Overhead pass',
      'Block jump', 'Beach or indoor', 'Volley hit', 'Rotation positions', 'Ball rally',
      'Volleyball court', 'Spike goal', 'Net jump', 'Team volley', 'Volleyball match',
      'Serve and pass', 'Court match', 'Net sport', 'Volley match', 'Ball rally game',
      'High net game', 'Spike match', 'Volleyball game', 'Court volley', 'Net match'
    ]),
    WordEntry('Table Tennis', [
      'Miniature table', 'Ping pong ball', 'Small paddle', 'Center net', 'Spin serve',
      'Fast rally', 'Table court', 'Celluloid ball', 'Paddle hit', 'Table match',
      'Ping pong game', 'Indoor table', 'Quick reaction', 'Spin shot', 'Table tennis court',
      'Paddle sport', 'Fast reaction', 'Table rally', 'TT match', 'Ping pong match',
      'Table sport', 'Paddle game', 'TT game', 'Table rally game', 'Ping pong play'
    ]),
    WordEntry('Swimming', [
      'Water pool', 'Strokes motion', 'Pool lanes', 'Diving board', 'Goggles worn',
      'Freestyle lap', 'Water sport', 'Aquatic exercise', 'Pool laps', 'Breath control',
      'Swimmer plunge', 'Water laps', 'Aquatic pool', 'Swim suit', 'Pool competition',
      'Water movement', 'Swim laps', 'Pool sport', 'Aquatic sport', 'Swimming match',
      'Pool exercise', 'Swim pool', 'Water exercise', 'Aquatic match', 'Swim sport'
    ]),
  ],

  // ─── 8. OCCUPATIONS ─────────────────────────────────────────────────────
  'Occupations': [
    WordEntry('Doctor', [
      'Medical expert', 'Stethoscope physician', 'White coat', 'Healing practitioner', 'Prescription writer',
      'Hospital clinic', 'Patient diagnosis', 'Medical degree', 'Health healer', 'Clinical care',
      'Treatment provider', 'Pulse checker', 'Health guardian', 'Medical consultant', 'Care practitioner',
      'Physician doctor', 'Health expert', 'Clinical doctor', 'Medical provider', 'Patient healer',
      'Health physician', 'Care doctor', 'Medical healer', 'Clinic practitioner', 'Doctor consultant'
    ]),
    WordEntry('Teacher', [
      'Knowledge mentor', 'Classroom educator', 'Blackboard writer', 'Lesson instructor', 'Student guide',
      'School teacher', 'Exam evaluator', 'Subject expert', 'Class instructor', 'Academic guide',
      'Knowledge giver', 'Teaching professional', 'School instructor', 'Education mentor', 'Classroom teacher',
      'Learning guide', 'Book mentor', 'Class mentor', 'Academic teacher', 'Subject instructor',
      'Education teacher', 'Lesson mentor', 'School mentor', 'Classroom guide', 'Teaching instructor'
    ]),
    WordEntry('Police Officer', [
      'Law enforcement', 'Uniformed officer', 'Badge holder', 'Patrol duty', 'Crime solver',
      'Police station', 'Law protector', 'Safety guardian', 'Handcuffs duty', 'Public order',
      'Patrol officer', 'Security keeper', 'City police', 'Officer duty', 'Law keeper',
      'Police uniform', 'Justice officer', 'Safety officer', 'Police duty', 'Crime prevention',
      'Law officer', 'Protector officer', 'Safety keeper', 'Police guard', 'Security officer'
    ]),
    WordEntry('Chef / Cook', [
      'Culinary master', 'Kitchen expert', 'Recipe creator', 'Chef hat', 'Cooking artist',
      'Restaurant kitchen', 'Gourmet preparer', 'Flavor maker', 'Food creator', 'Kitchen leader',
      'Dish preparer', 'Culinary chef', 'Cooking professional', 'Meal artist', 'Kitchen chef',
      'Recipe master', 'Food artist', 'Culinary maker', 'Restaurant chef', 'Dining preparer',
      'Culinary expert', 'Meal chef', 'Dish creator', 'Food chef', 'Cooking master'
    ]),
    WordEntry('Pilot', [
      'Cockpit aviator', 'Aircraft captain', 'Sky navigator', 'Flight captain', 'Uniformed aviator',
      'Runway takeoff', 'Airplane pilot', 'Flight control', 'Air travel lead', 'Aviation expert',
      'Sky flyer', 'Cockpit pilot', 'Flight aviator', 'Airplane captain', 'Aviation captain',
      'Aerial navigator', 'Flight expert', 'Jet pilot', 'Air captain', 'Sky captain',
      'Aviation flyer', 'Flight leader', 'Airplane flyer', 'Aerial pilot', 'Cockpit flyer'
    ]),
    WordEntry('Driver', [
      'Vehicle operator', 'Steering wheel lead', 'Road navigator', 'Chauffeur driver', 'Vehicle navigator',
      'Street driver', 'Commute operator', 'Route navigator', 'Road driver', 'Driving expert',
      'Cab driver', 'Transit operator', 'Vehicle driver', 'Transport operator', 'Road operator',
      'Wheel operator', 'Street navigator', 'Vehicle controller', 'Drive operator', 'Road professional',
      'Traffic driver', 'Transit driver', 'Route driver', 'Commute driver', 'Vehicle captain'
    ]),
    WordEntry('Farmer / Kisan', [
      'Agricultural cultivator', 'Crop grower', 'Field worker', 'Soil tiller', 'Harvest gatherer',
      'Green fields', 'Tractor operator', 'Monsoon dependent', 'Grain grower', 'Farm cultivator',
      'Rural worker', 'Agriculture expert', 'Crop producer', 'Soil farmer', 'Harvest farmer',
      'Farm grower', 'Land cultivator', 'Food producer', 'Field cultivator', 'Agricultural grower',
      'Crop farmer', 'Farm worker', 'Soil cultivator', 'Field grower', 'Agricultural worker'
    ]),
    WordEntry('Software Engineer', [
      'Code developer', 'Software architect', 'Programmer mind', 'Keyboard typer', 'System builder',
      'Computer coder', 'App developer', 'Digital creator', 'Tech professional', 'Screen coder',
      'Algorithm coder', 'Software creator', 'Tech engineer', 'Program developer', 'Code architect',
      'System coder', 'Digital architect', 'IT professional', 'Tech coder', 'Software expert',
      'Developer engineer', 'Code builder', 'Software programmer', 'Tech builder', 'Digital engineer'
    ]),
  ],

  // ─── 9. TECHNOLOGY ──────────────────────────────────────────────────────
  'Technology': [
    WordEntry('Smartphone', [
      'Pocket computer', 'Touchscreen display', 'Mobile phone', 'App device', 'Cellular gadget',
      'Handheld screen', 'Smart device', 'Pocket gadget', 'Mobile technology', 'Digital phone',
      'Touch gadget', 'Pocket screen', 'Smart mobile', 'Cellular phone', 'Handheld device',
      'Digital communicator', 'Mobile screen', 'Smart gadget', 'Portable computer', 'Touch phone',
      'Pocket communicator', 'Smart device', 'Mobile gadget', 'Digital device', 'Handheld phone'
    ]),
    WordEntry('Laptop', [
      'Portable computer', 'Folding screen', 'Keyboard laptop', 'Workstation device', 'Trackpad notebook',
      'Clamshell computer', 'Mobile PC', 'Digital workstation', 'Portable PC', 'Notebook computer',
      'Office laptop', 'Personal computer', 'Screen and keys', 'Foldable PC', 'Work laptop',
      'Digital notebook', 'Computing device', 'Portable workstation', 'Laptop computer', 'Mobile workstation',
      'Portable device', 'Notebook PC', 'Clamshell device', 'Desktop replacement', 'Personal PC'
    ]),
    WordEntry('Earbuds', [
      'Wireless audio', 'In-ear pods', 'Audio drivers', 'Sound buds', 'Bluetooth earpieces',
      'Music pods', 'Ear canal fit', 'Charging case', 'Pocket audio', 'Wireless earpieces',
      'Compact pods', 'Personal audio', 'Sound earpieces', 'Bluetooth pods', 'Music earpieces',
      'Portable audio', 'In-ear audio', 'Sound drivers', 'Wireless pods', 'Compact audio',
      'Ear audio', 'Personal earpieces', 'Pocket pods', 'Bluetooth drivers', 'Audio pods'
    ]),
    WordEntry('Smartwatch', [
      'Wrist computer', 'Fitness tracker', 'Digital watch', 'Smart timepiece', 'Pulse monitor',
      'Wrist display', 'Wearable tech', 'Step counter', 'Smart wristband', 'Digital timepiece',
      'Health tracker', 'Wrist gadget', 'Wearable display', 'Smart band', 'Wrist monitor',
      'Digital wristband', 'Tech timepiece', 'Wearable gadget', 'Fitness watch', 'Smart tracker',
      'Wrist tech', 'Wearable device', 'Digital tracker', 'Timepiece tech', 'Smart wrist'
    ]),
    WordEntry('Smart TV', [
      'Connected display', 'Living room screen', 'Streaming television', 'App screen', 'Big display',
      'Digital TV', 'Smart television', 'Home screen', 'Connected screen', 'Streaming TV',
      'Display screen', 'Smart monitor', 'Internet TV', 'Living room display', 'Home TV',
      'Digital television', 'Connected TV', 'Smart display', 'Television screen', 'App TV',
      'Smart video screen', 'Home entertainment TV', 'Streaming display', 'Connected monitor', 'Smart screen'
    ]),
    WordEntry('Wi-Fi Router', [
      'Wireless gateway', 'Internet hub', 'Signal box', 'Network router', 'Antenna gateway',
      'Wi-Fi box', 'Data hub', 'Broadband box', 'Wireless router', 'Network gateway',
      'Internet router', 'Signal hub', 'Wi-Fi gateway', 'Data router', 'Broadband router',
      'Connectivity box', 'Network hub', 'Wireless box', 'Internet gateway', 'Signal router',
      'Wi-Fi hub', 'Data box', 'Broadband hub', 'Wireless hub', 'Network box'
    ]),
    WordEntry('Camera', [
      'Image capturer', 'Lens optic', 'Shutter button', 'Photography device', 'Digital lens',
      'Picture taker', 'Optic camera', 'Photo device', 'Lens device', 'Frame capturer',
      'Digital camera', 'Snapshot device', 'Optic lens', 'Photography camera', 'Image device',
      'Shutter camera', 'Lens capturer', 'Picture device', 'Photo camera', 'Optic capturer',
      'Digital capturer', 'Frame device', 'Snapshot camera', 'Image lens', 'Photography lens'
    ]),
    WordEntry('Drone', [
      'Flying quadcopter', 'Aerial camera', 'Propeller flyer', 'Remote flyer', 'Sky drone',
      'Aerial flyer', 'Flight quadcopter', 'Remote drone', 'Sky flyer', 'Propeller drone',
      'Aerial device', 'Flying camera', 'Flight drone', 'Unmanned flyer', 'Sky camera',
      'Quadcopter drone', 'Aerial vehicle', 'Remote camera', 'Flight quadcopter', 'Propeller craft',
      'Flying craft', 'Aerial quadcopter', 'Sky quadcopter', 'Remote aircraft', 'Drone flyer'
    ]),
  ],

  // ─── 10. NATURE ─────────────────────────────────────────────────────────
  'Nature': [
    WordEntry('Volcano', [
      'Erupting mountain', 'Molten lava', 'Ash plume', 'Volcanic peak', 'Magma chamber',
      'Crater peak', 'Fiery mountain', 'Lava flow', 'Geological eruption', 'Volcanic crater',
      'Eruption mountain', 'Molten peak', 'Ash cloud', 'Lava mountain', 'Volcanic vent',
      'Fiery peak', 'Earth eruption', 'Magma mountain', 'Volcanic explosion', 'Crater mountain',
      'Lava eruption', 'Fiery vent', 'Molten eruption', 'Geological peak', 'Volcanic mountain'
    ]),
    WordEntry('Rainbow', [
      'Color arc', 'Seven shade spectrum', 'Sky prism', 'Post-rain arc', 'Vibrant spectrum',
      'Sky arch', 'Prismatic arch', 'Sunlight refraction', 'Colorful sky arc', 'Rain rainbow',
      'Spectral arch', 'Sky spectrum', 'Prismatic arc', 'Color arch', 'Atmospheric arc',
      'Post-storm arch', 'Sunlight arc', 'Refraction spectrum', 'Vibrant arc', 'Sky colors',
      'Spectral prism', 'Color rainbow', 'Prismatic spectrum', 'Sky rainbow', 'Vibrant arch'
    ]),
    WordEntry('Waterfall', [
      'Cascading stream', 'Water drop', 'Plunging river', 'Waterfall cascade', 'Mist spray',
      'Cliff drop', 'Rushing cascade', 'River plunge', 'Foam spray', 'Water drop cliff',
      'Cascading river', 'Cliff cascade', 'Water plunge', 'Stream drop', 'River cascade',
      'Mist cascade', 'Plunging stream', 'Waterfall drop', 'Rushing stream', 'Foam cascade',
      'Cliff plunge', 'River waterfall', 'Cascading water', 'Water stream drop', 'Plunging waterfall'
    ]),
    WordEntry('Monsoon Season', [
      'Rainy season', 'Wet monsoon', 'Downpour months', 'Overcast season', 'Rainfall period',
      'Subtropical monsoon', 'Rain season', 'Downpour season', 'Wet weather period', 'Monsoon rainfall',
      'Overcast months', 'Rainfall season', 'Monsoon downpour', 'Wet period', 'Rainy months',
      'Seasonal rain', 'Monsoon weather', 'Downpour period', 'Wet season', 'Rainfall months',
      'Subtropical rain season', 'Monsoon months', 'Seasonal downpour', 'Rain period', 'Wet monsoon season'
    ]),
    WordEntry('Lightning', [
      'Electric flash', 'Thunderbolt flash', 'Sky spark', 'Cloud discharge', 'Electric bolt',
      'Flash of light', 'Storm lightning', 'Electric flash streak', 'Thunderbolt streak', 'Sky discharge',
      'Storm flash', 'Cloud streak', 'Electric bolt flash', 'Thunderbolt spark', 'Sky flash',
      'Lightning bolt', 'Electric streak', 'Storm bolt', 'Cloud lightning', 'Thunderbolt light',
      'Sky electric spark', 'Lightning flash', 'Storm electric bolt', 'Cloud electric streak', 'Flash bolt'
    ]),
    WordEntry('Desert', [
      'Arid wasteland', 'Sand dunes', 'Dry expanse', 'Barren sand', 'Hot climate',
      'Desert dunes', 'Arid landscape', 'Sunbaked sand', 'Dry desert', 'Sand landscape',
      'Arid wilderness', 'Dune landscape', 'Hot wasteland', 'Dry sand expanse', 'Desert wilderness',
      'Sand expanse', 'Arid environment', 'Barren landscape', 'Hot desert', 'Sand environment',
      'Dry wilderness', 'Arid sand', 'Dune expanse', 'Sunbaked desert', 'Desert landscape'
    ]),
    WordEntry('Forest', [
      'Wooded canopy', 'Dense trees', 'Green woodland', 'Forest wilderness', 'Tree canopy',
      'Woodland forest', 'Jungle foliage', 'Green forest', 'Dense woods', 'Forest canopy',
      'Wooded landscape', 'Tree wilderness', 'Woodland canopy', 'Green canopy', 'Forest environment',
      'Dense forest', 'Wooded wilderness', 'Jungle canopy', 'Tree landscape', 'Forest woods',
      'Woodland environment', 'Green woods', 'Canopy forest', 'Dense woodland', 'Forest trees'
    ]),
    WordEntry('Snowy Mountain', [
      'Alpine peak', 'Snowy summit', 'Frozen mountain', 'Ice peak', 'Snowy height',
      'Mountain summit', 'Alpine height', 'Glacier peak', 'Frozen summit', 'Snowy landscape',
      'Mountain peak', 'Alpine summit', 'Ice mountain', 'Snowy range', 'Glacier mountain',
      'Frozen height', 'Alpine range', 'Snowy peak', 'Ice summit', 'Mountain range',
      'Glacier height', 'Alpine mountain', 'Frozen peak', 'Snowy alpine', 'Mountain height'
    ]),
  ],
};
