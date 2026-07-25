class WordEntry {
  final String word;
  final List<String> hints;
  const WordEntry(this.word, this.hints);
}

const Map<String, List<WordEntry>> wordBank = {
  // ─── 1. DESI FOOD & DRINKS ───────────────────────────────────────────────
  'Food & Drinks': [
    WordEntry('Chai / Tea', [
      'Tapri', 'Kulhad', 'Morning starter', 'Adrak', 'Elaichi',
      'Cutting', 'Boiling pot', 'Strainer', 'Biscuit dipping', 'Stall gossip',
      'Caffeine kick', 'Subah ki shuruaat', 'Steaming cup', 'Kettle', 'Milk and sugar',
      'Evacuates sleep', 'Addictive habit', 'Rainy day craving', 'Office break', 'Thermose',
      'Dukan', 'Masala brew', 'Sip by sip', 'Dabba snack partner', 'Stirred continuously'
    ]),
    WordEntry('Momo / Dumpling', [
      'Steamed pouch', 'Red spicy chutney', 'Mayonnaise dip', 'Chicken or veg filling', 'Street stall favourite',
      'Kathmandu origin', 'Bamboo steamer', 'Dough pocket', 'Soup bowls', 'Juicy inside',
      'Fried or C-momo', 'Plate of ten', 'Toothpick stick', 'Evening snack', 'Folding edges',
      'Cold weather food', 'Student budget', 'Fast food counter', 'Corner shop', 'Dipping sauce',
      'Flour wrapper', 'Hot bite', 'Minced filling', 'Byte size', 'Spicy kick'
    ]),
    WordEntry('Samosa', [
      'Triangular shape', 'Potato filled', 'Fried golden brown', 'Green chutney', 'Meethi chutney',
      'Chhole combo', 'Tea time partner', 'Maida crust', 'Crispy corners', 'Ajwain flavor',
      'Halwai shop', 'Rainy day snack', 'Street food classic', 'Deep oil fry', 'Hot pocket',
      'Spicy filling', 'Peas and spices', 'Break time treat', 'Party starter', 'Crushed on plate',
      'Messy bite', 'Evening hunger', 'Traditional snack', 'Popular Indian bite', 'Dukan shelf'
    ]),
    WordEntry('Pani Puri', [
      'Crispy hollow ball', 'Spiced tangy water', 'Teekha vs Meetha', 'Potato chickpea fill', 'One bite full',
      'Street vendor counter', 'Bhaiya ek aur', 'Sukha puri last', 'Mint coriander water', 'Exploding flavor',
      'Earthen bowl', 'Paper plate', 'Crowd standing', 'Evening crowd', 'Snack obsession',
      'Chilli hit', 'Tamarind tang', 'Crispy crunch', 'Quick swallow', 'Flavour bomb',
      'Popular street bite', 'Filling hole', 'Water jug', 'Dahi variant', 'Snack stall'
    ]),
    WordEntry('Biryani', [
      'Basmati rice', 'Fragrant spices', 'Handi cooked', 'Dum process', 'Raita partner',
      'Chicken or mutton', 'Saffron color', 'Fried onions top', 'Layered cooking', 'Festival feast',
      'Kolkata or Hyderabadi', 'Kewra essence', 'Cardamom scent', 'Marinated meat', 'Clay pot seal',
      'Royal dish', 'Weekend lunch', 'Spicy rice', 'Salan side', 'Plate full',
      'Big celebration', 'Ghee aroma', 'Clove flavor', 'Biryani lovers', 'Rich meal'
    ]),
    WordEntry('Jalebi', [
      'Spiral loops', 'Deep fried batter', 'Soaked in sugar syrup', 'Crispy and juicy', 'Orange yellow glow',
      'Rabri combination', 'Breakfast treat', 'Halwai ka Kadhai', 'Sticky fingers', 'Sweet tooth',
      'Hot off oil', 'Festive sweet', 'Circular coil', 'Melt in mouth', 'Festival staple',
      'Syrup dip', 'Morning snack', 'Crunchy bite', 'Desi dessert', 'Street halwai',
      'Saffron hint', 'Traditional sweet', 'Snack combo', 'Sweet spirals', 'Sugar rush'
    ]),
    WordEntry('Lassi', [
      'Thick yogurt drink', 'Earthen kulhad', 'Malai on top', 'Sweet or salted', 'Summer cooler',
      'Punjab origin', 'Wooden churner', 'Roohafza flavor', 'Heavy stomach', 'Ice chilled',
      'Creamy layer', 'Glass full', 'Dhabha favorite', 'Sip after meal', 'Dry fruit topping',
      'Refreshing beverage', 'Curd blend', 'Tall brass glass', 'Afternoon drink', 'Nutritious sip',
      'Creamy texture', 'Digestive option', 'Sweet sip', 'Traditional drink', 'Summer savior'
    ]),
    WordEntry('Dal Bhat', [
      'Nepali national dish', 'Lentil soup', 'Steamed rice', 'Tarkari side', 'Achar pickle',
      'Papad crunch', 'Daily staple', 'Two times a day', 'Plate layout', 'Brass thali',
      'Ghee drizzle', 'Comfort meal', 'Energy for trekking', 'Power of 24 hours', 'Simple living',
      'Home cooking', 'Mother\'s kitchen', 'Mixing with hand', 'Nutritious balance', 'Everyday dinner',
      'Saag side', 'Warm bowl', 'Grain and legume', 'Authentic taste', 'Traditional thali'
    ]),
  ],

  // ─── 2. CULTURE & FESTIVALS ─────────────────────────────────────────────
  'Culture & Festivals': [
    WordEntry('Diwali / Tihar', [
      'Festival of lights', 'Diyo oil lamps', 'Rangoli designs', 'Firecrackers', 'Laxmi Puja',
      'Sweets distribution', 'New clothes', 'Marigold garlands', 'Bhai Tika / Dooj', 'Light over darkness',
      'Home cleaning', 'Card games evening', 'Sparklers', 'Lighting earthen pots', 'Doorstep decor',
      'Family reunion', 'Festival season', 'Night illumination', 'Puja thali', 'Festive spirit',
      'Goddess blessing', 'Dry fruit boxes', 'Celebration week', 'Bright windows', 'Joyous mood'
    ]),
    WordEntry('Holi', [
      'Festival of colors', 'Gulal powder', 'Water balloons', 'Pichkari pump', 'Gujiya sweet',
      'Bhang thandai', 'Old clothes worn', 'White shirt ruined', 'Music and dance', 'Spring arrival',
      'Face painting', 'Bucket of water', 'Color throw', 'Friendly hugs', 'Street madness',
      'Festive songs', 'Balam Pichkari', 'Joyous laughter', 'Community gather', 'Stained hands',
      'Color wash off', 'March celebration', 'Fun mayhem', 'Playful battle', 'Festive vibe'
    ]),
    WordEntry('Bollywood', [
      'Film industry', 'Mumbai center', 'Dramatic storylines', 'Song and dance', 'Superstars',
      'Box office hit', 'Cinema halls', '3 hour runtime', 'Intermission break', 'Melodramatic dialogue',
      'Romance and action', 'Item numbers', 'Choreographed dance', 'Paprazzi hype', 'Silver screen',
      'Playback singers', 'Award shows', 'Star glamour', 'Blockbuster', 'Fan frenzy',
      'Pop culture', 'Film posters', 'Hero heroines', 'Masala movie', 'Entertainment hub'
    ]),
    WordEntry('Auto Rickshaw', [
      'Three wheeler', 'Yellow and green', 'Meter reader', 'Bhaiya chaloge', 'Loud horn noise',
      'Traffic weaver', 'Black hood canopy', 'Street commute', 'Short distance', 'Fare negotiation',
      'Engine sputter', 'Open sides', 'Rear seat', 'Shared auto option', 'City transport',
      'Auto stand', 'Driver mirror', 'Knock on hood', 'Hand signals', 'Narrow lanes',
      'Daily travel', 'Quick ride', 'Coin change', 'Urban icon', 'Vehicle ride'
    ]),
    WordEntry('Cricket', [
      'Eleven players', 'Wickets and stumps', 'Leather ball', 'Wooden bat', 'Six runs hit',
      'Boundary line', 'Umpire signal', 'LBW decision', 'IPL tournament', 'TOSS before match',
      'Pitch condition', 'Gully cricket', 'Rubber ball', 'Over by over', 'Catch out',
      'Stadium roar', 'National obsession', 'Commentary mic', 'Pad and helmet', 'Bowling runup',
      'Century score', 'Match day', 'World Cup', 'Cheering fans', 'Gentleman game'
    ]),
    WordEntry('Shaadi / Marriage', [
      'Band baaja', 'Barat procession', 'Mandap altar', 'Seven vows', 'Mehndi henna',
      'Sangeet night', 'Red saree / Lehanga', 'Dulha Dulhan', 'Heavy jewelry', 'Buffet dinner',
      'Gold exchange', 'Relatives gather', 'Photo session', 'Late night rituals', 'Haldi ceremony',
      'Wedding invitation', 'Milni hug', 'Stage photoshoot', 'Joota chupai', 'Emotional bidai',
      'Festive venue', 'Grand decor', 'Life commitment', 'Cultural event', 'Family celebration'
    ]),
    WordEntry('Monsoon Rain', [
      'Dark clouds', 'Heavy downpour', 'Paper boats', 'Chai and pakora', 'Thunder rumbling',
      'Wet mud smell (Petrichor)', 'Umbrella opened', 'Waterlogged streets', 'Puddle jumping', 'Cool breeze',
      'Raincoat worn', 'Rainy season', 'Greenery all around', 'Leaky roofs', 'Traffic jams',
      'Hot tea craving', 'Lightning flashes', 'Splash sound', 'Subtropical monsoon', 'Flooded roads',
      'Farmers joy', 'Cozy indoor', 'Drizzling drops', 'Rain song', 'Nature wash'
    ]),
    WordEntry('Jugaad', [
      'Clever shortcut', 'Frugal innovation', 'Make-do solution', 'Hacks and fixes', 'Improvised tool',
      'Unconventional fix', 'Problem solving', 'Saving money', 'Desi genius', 'Resourcefulness',
      'Quick patch', 'Tape and wire', 'Temporary fix', 'Out of box thinking', 'Local wisdom',
      'Smart alternative', 'No wastage', 'Practical mind', 'Indian mindset', 'Creative workaround',
      'Clever mind', 'Fixing broken items', 'Efficiency hack', 'Desi style', 'Smart trick'
    ]),
  ],

  // ─── 3. EVERYDAY OBJECTS ────────────────────────────────────────────────
  'Everyday Objects': [
    WordEntry('Pressure Cooker', [
      'Whistle sound (Seeti)', 'Safety valve', 'Rubber gasket ring', 'Gasket leak', 'Kitchen appliance',
      'Steam pressure', 'Lentil boiling', 'Rice cooking', 'Stovetop pot', 'Aluminium or steel',
      'Handle lock', 'Kitchen noise', 'Mother\'s signal', 'Faster cooking', 'Hot steam release',
      'Dinner preparation', 'Countertop item', 'Hissing sound', 'Stove partner', 'Dal cooker',
      'Weight on top', 'Kitchen essential', 'Cooking pot', 'Steam build', 'Meal maker'
    ]),
    WordEntry('Chappal / Slippers', [
      'Rubber footwear', 'Flip flop strap', 'Mom\'s flying weapon', 'Home wear', 'Bathroom slippers',
      'Toe grip', 'Walking inside house', 'Cheap and casual', 'Outside door left', 'Foot protection',
      'Flat sole', 'Worn daily', 'Easy slip on', 'Plastic or rubber', 'Slapping sound',
      'Floor walker', 'Shoe rack item', 'Casual wear', 'Indoor footwear', 'Pair of two',
      'Doorstep left', 'House slipper', 'Strap holding', 'Summer footwear', 'Simple style'
    ]),
    WordEntry('Steel Glass', [
      'Unbreakable vessel', 'Stainless steel', 'Cold water container', 'Kitchen shelf item', 'Dhaba drinking glass',
      'Durable metal', 'Shiny surface', 'Water and milk sip', 'No handle design', 'Washed after meal',
      'Stackable cups', 'Everyday drinkware', 'Metallic sound', 'Indian kitchen item', 'Chilled water sweat',
      'Simple design', 'Metal tumbler', 'Household essential', 'Utensil rack', 'Dinner table item',
      'Drinking vessel', 'Solid build', 'Silver look', 'Hydration container', 'Daily item'
    ]),
    WordEntry('Carrom Board', [
      'Square wooden board', 'White and black pawns', 'Red queen (Rani)', 'Striker puck', 'Boric powder smooth',
      'Corner pockets', 'Finger flicking', 'Family board game', 'Veranda indoor fun', 'Flick mechanics',
      'Board game evening', 'Pocketing coins', 'Covering queen', 'Pawn layout', 'Smooth gliding',
      'Recreation sport', 'Point scoring', 'Wooden frame', 'Flick angle', 'Center circle',
      'Tabletop game', 'Weekend pass time', 'Friends gathering', 'Indoor match', 'Classic board'
    ]),
    WordEntry('Ludo Board', [
      'Four colors', 'Dice roll (Pasa)', 'Tokens moving', 'Home center square', 'Cutting opponent token',
      'Snakes and ladders combo', 'Board game app', 'Family quarrel game', 'Roll a six', 'Board grid',
      'Safe stars', 'Red blue green yellow', 'Casual gaming', 'Lockdown trend', 'Token entry',
      'Turn taking', 'Pass time', 'Tabletop fun', 'Lucky roll', 'Board match',
      'Counting steps', 'Game of luck', 'Mobile app trend', 'Classic game', 'Players four'
    ]),
    WordEntry('Matchbox / Machis', [
      'Small cardboard box', 'Strike on side', 'Wood sticks inside', 'Red phosphorus tip', 'Fire starter',
      'Lighting candle', 'Lighting diyo', 'Kitchen drawer', 'Pocket size item', 'Small flame',
      'Friction spark', 'Burnt stick smell', 'Smoke puff', 'Lighting incense (Agarbatti)', 'Popping spark',
      'Fire hazard', 'Small box', 'Utility item', 'Wood splint', 'Flame maker',
      'Lighting stove', 'Everyday item', 'Matches inside', 'Lighting fire', 'Essential box'
    ]),
    WordEntry('Broom / Jhadu', [
      'Long bristles', 'Floor cleaning', 'Dust sweeping', 'Morning routine', 'Lakshmi symbol',
      'Handheld tool', 'Dustpan partner', 'Coconut or grass fibers', 'Sweeping motion', 'House cleanliness',
      'Corners cleaning', 'Mother\'s hand', 'Floor maintenance', 'Kitchen sweep', 'Dirty floor',
      'Dust removal', 'Housework essential', 'Trash collector', 'Daily chore', 'Indoor cleaning',
      'Long handle', 'Straw bristles', 'Floor tool', 'Sweeper item', 'Cleaning device'
    ]),
    WordEntry('Umbrella', [
      'Shields from rain', 'Opens and closes', 'Carried in hand', 'Metal ribs frame', 'Waterproof canopy',
      'Sunshade function', 'Wind resistance', 'Folding model', 'Hook handle', 'Wet after rain',
      'Drying in balcony', 'Monsoon partner', 'Color patterns', 'Portable shade', 'Rain protector',
      'Pocket size folding', 'Drip drops', 'Outdoor travel', 'Sun protection', 'Easy grip',
      'Canopy fabric', 'Storm companion', 'Handheld shield', 'Rainy day item', 'Weather gear'
    ]),
  ],

  // ─── 4. PLACES & TRAVEL ─────────────────────────────────────────────────
  'Places & Travel': [
    WordEntry('Airport', [
      'Flight departure', 'Security checkpoint', 'Boarding pass', 'Luggage trolley', 'Runway tarmac',
      'Control tower', 'Passport check', 'Duty free shops', 'Airplane parking', 'Gate waiting',
      'Flight announcements', 'Baggage claim belt', 'Terminal building', 'Travel hub', 'Overhead flight',
      'Jet engines', 'Customs clearance', 'Travelers waiting', 'Flight delay', 'Pilot crew',
      'Air travel', 'Window seat', 'Check in counter', 'Big building', 'Global connection'
    ]),
    WordEntry('Hospital', [
      'White coats', 'Stethoscope doctors', 'Emergency ward (ER)', 'Nurses caring', 'Patient beds',
      'Medicine smell', 'Operating theater', 'Intensive care (ICU)', 'Ambulance siren', 'Wheelchairs',
      'Syringe needles', 'Quiet corridors', 'Health checkup', 'Drip bottle', 'Medical charts',
      'Appointment desk', 'Surgical masks', 'Healing center', 'Bandages and gauze', 'Pharmacy section',
      'Health recovery', 'Blood test lab', 'Vital signs', 'Caregivers', 'Clinic setup'
    ]),
    WordEntry('Railway Station', [
      'Train tracks', 'Platform numbers', 'Coolie porter', 'Chai hot tea stall', 'Locomotive engine',
      'Passenger train', 'Ticket counter', 'Reservation chart', 'Whistle toot', 'Track switches',
      'Signal lights', 'Overhead bridge', 'Luggage stacks', 'Waiting hall', 'Train announcement',
      'Speeding trains', 'Metal rails', 'Public transport', 'Travel hub', 'Coupe berth',
      'Clock on platform', 'Crossings', 'Horn sound', 'Station master', 'Long journey'
    ]),
    WordEntry('School', [
      'Classroom desks', 'Blackboard / Whiteboard', 'Teacher lecturing', 'School uniform', 'Bell ringing',
      'Recess lunch break', 'Homework assignment', 'Morning assembly', 'Textbooks and notebooks', 'Report card',
      'Exam paper', 'Principal office', 'Playground games', 'Students listening', 'Attendance roll call',
      'Pencil box', 'School bus', 'Education center', 'Annual function', 'Classmates',
      'Learning spot', 'Subject teacher', 'Studies', 'Friends group', 'Childhood spot'
    ]),
    WordEntry('Cinema Hall', [
      'Movie screen', 'Projector room', 'Popcorn tub', 'Recliner seats', 'Intermission time',
      'Surround sound', 'Ticket booking', 'Dark hall', 'Movie trailers', 'Box office hit',
      'Cinema curtain', 'Row letters', 'Crisp audio', 'Big screen experience', 'Housefull sign',
      'Movie fans', 'Film show', 'Night show', 'Theatre snack', '3D glasses',
      'Film reel', 'Entertainment hall', 'Show timing', 'Audi hall', 'Film venue'
    ]),
    WordEntry('Local Bazaar', [
      'Crowded lanes', 'Vendor stalls', 'Bargaining prices', 'Street vendors', 'Fresh vegetables',
      'Shopping bags', 'Loud shouting sellers', 'Noise and hustle', 'Vegetable carts', 'Footwear shops',
      'Street food stalls', 'Buying and selling', 'Narrow alleys', 'Cash payments', 'Evening crowd',
      'Scale weighing', 'Product displays', 'Local shopping', 'Commercial hub', 'Everything available',
      'Busy streets', 'Shoppers walking', 'Cloth market', 'Storefronts', 'City market'
    ]),
    WordEntry('Temple / Mandir', [
      'Bell ringing (Ghanti)', 'Incense smoke (Agarbatti)', 'Prayer offerings (Prasad)', 'Idol deity', 'Shoe stand outside',
      'Priest / Pujari', 'Floral garlands', 'Chanting mantras', 'Sacred spot', 'Peaceful vibe',
      'Oil lamps (Diyo)', 'Sanskrit prayers', 'Devotees queue', 'Architectural spire (Shikhara)', 'Morning Aarti',
      'Donation box', 'Circumambulation (Parikrama)', 'Holy place', 'Spiritual energy', 'Barefoot walking',
      'Red tilak', 'Conch shell (Sankh)', 'Divine atmosphere', 'Faith center', 'Worship spot'
    ]),
    WordEntry('Trekking Trail', [
      'Himalayan peaks', 'Backpack hiking', 'Narrow path', 'Winding trails', 'Steep climb',
      'Wooden walking stick', 'Mountain view', 'Tea house lodge', 'Cold altitude', 'Fresh mountain air',
      'Pine trees', 'Snowy heights', 'Scenic valleys', 'Heavy boots', 'Map and compass',
      'Trekker group', 'Suspension bridges', 'High elevation', 'Nature trek', 'Camping tent',
      'Rocky terrain', 'Adventure walk', 'Summit goal', 'Outdoors hike', 'Mountain trail'
    ]),
  ],

  // ─── 5. ANIMALS & WILDLIFE ──────────────────────────────────────────────
  'Animals': [
    WordEntry('Dog', [
      'Loyal friend', 'Barks loud', 'Fetches stick', 'Wags tail', 'Wears collar',
      'Guards house', 'Puppy eyes', 'Canine species', 'Leash walk', 'Pet animal',
      'Sniffs around', 'Chews bones', 'Four legs', 'Man\'s best friend', 'Fur coat',
      'Vet visits', 'Whined sound', 'Paws print', 'Playful pet', 'Street stray',
      'Pedigree food', 'Alert ears', 'Subah walk', 'Furry buddy', 'Barking pet'
    ]),
    WordEntry('Cat', [
      'Purrs softly', 'Nine lives', 'Meow sound', 'Drinks milk', 'Catches mice',
      'Sharp claws', 'Feline family', 'Whiskers face', 'Loves nap', 'Agile climber',
      'Soft fur', 'Night eyes', 'Pet animal', 'Playful yarn', 'Scratch post',
      'Independent nature', 'Padded paws', 'Tail flick', 'Litter box', 'Quiet walker',
      'Kitty pet', 'Clean fur', 'Furry pet', 'Sleepy animal', 'Cute pet'
    ]),
    WordEntry('Elephant', [
      'Trunk nose', 'Large tusks', 'Big floppy ears', 'Largest land animal', 'Loves bananas',
      'Gray thick skin', 'Trumpet sound', 'Heavy footsteps', 'Jungle giant', 'Mahout rider',
      'Temple procession', 'Water spraying', 'Herbivore giant', 'Big memory', 'Stump legs',
      'Tail tuft', 'Wild animal', 'Forest herd', 'Heavy weight', 'Gentle giant',
      'Mud bath', 'Ivory horns', 'Big mammal', 'Jungle creature', 'Massive size'
    ]),
    WordEntry('Tiger', [
      'Orange black stripes', 'Jungle predator', 'National animal', 'Roar sound', 'Big feline cat',
      'Sharp fangs', 'Solitary hunter', 'Camouflage coat', 'Wild carnivore', 'Forest king',
      'Royal Bengal', 'Stalking prey', 'Paws and claws', 'Protected species', 'Wildlife reserve',
      'Safari view', 'Stealthy walk', 'Powerful jaws', 'Jungle cat', 'Big predator',
      'Territorial animal', 'Wild cat', 'Fierce beast', 'Stripe pattern', 'Jungle mammal'
    ]),
    WordEntry('Monkey', [
      'Jumps on trees', 'Loves bananas', 'Long tail', 'Chatter sound', 'Playful prankster',
      'Temple thief', 'Primate family', 'Swinging branches', 'Group troop', 'Red or black face',
      'Curious mind', 'Steals food', 'Hand agility', 'Climbing walls', 'Urban nuisance',
      'Tree creature', 'Scratching head', 'Wild animal', 'Forest mammal', 'Human cousin',
      'Mischievous pet', 'Hanging tail', 'Branch hopper', 'Jungle monkey', 'Smart animal'
    ]),
    WordEntry('Cow', [
      'Gives fresh milk', 'Sacred in culture (Gau Mata)', 'Moo sound', 'Chews cud', 'Horns on head',
      'Grazing grass', 'Four stomachs', 'Gentle animal', 'Dairy farm', 'Calf mother',
      'Hump back', 'Cowbell neck', 'Stray on roads', 'Farm animal', 'Domestic herbivore',
      'Milk provider', 'Tail swatter', 'Hooved feet', 'Peaceful gaze', 'Dung manure',
      'Pasture grazer', 'Farm creature', 'Useful animal', 'Dairy source', 'Revered animal'
    ]),
    WordEntry('Snake / Cobra', [
      'Slithers on ground', 'Fangs and venom', 'Hissing sound', 'No legs body', 'Sheds skin',
      'Hooded cobra', 'Snake charmer (Been)', 'Reptile species', 'Forked tongue', 'Underground hole',
      'Poisonous bite', 'Cold blooded', 'Coiled position', 'Silent creep', 'Rattlesnake / Viper',
      'Rodent hunter', 'Scary reptile', 'Scaly skin', 'Wild creature', 'Warning hiss',
      'Forest crawler', 'Lethal strike', 'Reptile hunter', 'Ground slither', 'Deadly bite'
    ]),
    WordEntry('Peacock', [
      'National bird', 'Colorful feathers', 'Monsoon rain dance', 'Blue green plumage', 'Crowned head',
      'Fan tail open', 'Loud cry sound', 'Beautiful bird', 'Wildlife sanctuary', 'Feather eyes pattern',
      'Graceful walk', 'Indian peacock', 'Avian species', 'Bird of paradise', 'Forest bird',
      'Large tail train', 'Festive bird', 'Wings spread', 'Wild bird', 'Feather collection',
      'Regal look', 'Nature dancer', 'Colorful tail', 'Majestic bird', 'Indian wildlife'
    ]),
  ],

  // ─── 6. MOVIES & TV ─────────────────────────────────────────────────────
  'Movies & TV': [
    WordEntry('Bollywood Movie', [
      'Mumbai film industry', 'Dramatic scenes', 'Song and dance sequence', 'Masala movies', 'Superstar heroes',
      'Box office collection', 'Playback music', 'Romantic plots', 'Intermission interval', 'Action drama',
      'Hindi cinema', 'Intermittent comedy', 'Film awards', 'Cinema screens', 'Trailer releases',
      'Paprazzi coverage', 'Blockbuster hits', 'Melodrama dialogues', 'Stunt action', 'Dance choreography',
      'Fan culture', 'Star glamor', 'Film direction', 'Indian cinema', 'Movie World'
    ]),
    WordEntry('Actor / Hero', [
      'Starring lead', 'Acting roles', 'Delivers dialogues', 'Performs stunts', 'Famous celebrity',
      'Fan following', 'On screen hero', 'Autograph sign', 'Red carpet walk', 'Film auditions',
      'Script reading', 'Makeup trailer', 'Camera action cut', 'Costume changes', 'Movie poster',
      'Superstar status', 'Award winner', 'Talent skills', 'Drama artist', 'Cinema personality',
      'Screen presence', 'Hero role', 'Leading man', 'Film star', 'Performing artist'
    ]),
    WordEntry('Popcorn Bucket', [
      'Cinema snack', 'Butter flavor', 'Popping corn kernels', 'Tub or bucket', 'Crispy crunch',
      'Salty bite', 'Movie watching partner', 'Snack counter', 'Warm and fresh', 'Yellow kernels',
      'Munching sound', 'Theater food', 'Puffed corn', 'Caramel variant', 'Snack box',
      'Movie intermission', 'Crispy snack', 'Light bite', 'Finger food', 'Cinema staple',
      'Tasty munchies', 'Popcorn machine', 'Theater bucket', 'Movie treat', 'Snack time'
    ]),
    WordEntry('Film Director', [
      'Megaphone / Calling Cut', 'Vision behind movie', 'Guide actors', 'Director chair', 'Script execution',
      'Film maker', 'Camera angles', 'Creative control', 'Action and Cut', 'Scene instructions',
      'Storyteller', 'Film set boss', 'Production helm', 'Movie creator', 'Cinematic vision',
      'Clapboard timing', 'Edits and cuts', 'Behind camera', 'Film project head', 'Casting decisions',
      'Shot approval', 'Creative lead', 'Movie guide', 'Set commander', 'Film director'
    ]),
    WordEntry('Television / TV', [
      'Living room screen', 'Remote control', 'Cable channels', 'Daily soaps / Serials', 'News broadcasts',
      'Sports streaming', 'Flat display', 'HDMI input', 'Binge watching', 'Prime time shows',
      'Commercial ads', 'Volume buttons', 'Set top box', 'Household screen', 'Broadcast shows',
      'Screen entertainment', 'Family watching', 'Channel surfing', 'Display unit', 'Wall mounted',
      'TV remote', 'Evening news', 'Drama serials', 'Entertainment box', 'Home screen'
    ]),
    WordEntry('OTT Web Series', [
      'Netflix / Prime / Hotstar', 'Subscription plan', 'Binge watching', 'Web series', 'Stream online',
      'No ads option', 'Mobile streaming', 'Play pause button', 'Watch history', 'New season release',
      'Wi-Fi streaming', 'HD 4K quality', 'User profile', 'Digital content', 'On demand shows',
      'Episodes list', 'Show recommendations', 'Screen time', 'Smart TV app', 'Download offline',
      'Modern entertainment', 'Streaming platform', 'Web shows', 'App subscription', 'Binge night'
    ]),
    WordEntry('Cricket Match TV', [
      'Live sports stream', 'Commentary box', 'Replay slow motion', 'Scoreboard ticker', 'Match analysis',
      'Commercial breaks', 'Third umpire review', 'Stadium crowd noise', 'Boundaries graphic', 'Over summary',
      'Wicket replay', 'Expert panel', 'Live coverage', 'Sports channel', 'Match highlights',
      'Hawk eye tracking', 'Ultra edge spike', 'Screen display', 'Game broadcast', 'Toss update',
      'Sports view', 'Match day live', 'Fan engagement', 'Sports stream', 'TV broadcast'
    ]),
    WordEntry('Comedy Standup', [
      'Laughter noise', 'Stand up comedian', 'Punchlines', 'Funny jokes', 'Audience giggles',
      'Humorous skits', 'Mic on stage', 'Comic timing', 'Laughter challenge', 'Giggly mood',
      'Hilarious acts', 'Smile and laugh', 'Fun program', 'Entertainment act', 'Comic artist',
      'Chuckle sound', 'Stage performance', 'Joke delivery', 'Light hearted show', 'Roast jokes',
      'Humor show', 'Laughter medicine', 'Funny lines', 'Stage comedy', 'Joyful act'
    ]),
  ],

  // ─── 7. SPORTS & GAMES ──────────────────────────────────────────────────
  'Sports': [
    WordEntry('Cricket', [
      'Eleven players', 'Wickets and stumps', 'Leather ball', 'Wooden bat', 'Six runs hit',
      'Boundary line', 'Umpire signal', 'LBW decision', 'IPL tournament', 'Toss before match',
      'Pitch condition', 'Gully cricket', 'Rubber ball', 'Over by over', 'Catch out',
      'Stadium roar', 'National obsession', 'Commentary mic', 'Pad and helmet', 'Bowling runup',
      'Century score', 'Match day', 'World Cup', 'Cheering fans', 'Gentleman game'
    ]),
    WordEntry('Football / Soccer', [
      'Black and white ball', 'Goal post net', 'Goalie goalkeeper', 'Yellow red card', 'Penalty kick',
      'Ninety minutes', 'Corner kick', 'Dribbling skills', 'Header shot', 'World Cup tournament',
      'Pitch turf', 'Referee whistle', 'Striker player', 'Pass the ball', 'Offside call',
      'Free kick', 'Cleats shoes', 'Stadium cheering', 'Team match', 'Kicking ball',
      'Out of bounds', 'Football match', 'Pitch battle', 'Goal score', 'Global sport'
    ]),
    WordEntry('Badminton', [
      'Feather shuttlecock', 'Lightweight racket', 'High net divider', 'Smash hit', 'Indoor court',
      'Single or doubles', 'Service line', 'Rally exchange', 'Drop shot', 'Volley back forth',
      'Fast pace game', 'Footwork court', 'Point scoring', 'Rubber grip', 'Olympic sport',
      'Non stop rally', 'Wrist flick', 'Out of line', 'Deuce score', 'Game set match',
      'Racket sport', 'Shuttle flight', 'Court game', 'Quick reflex', 'Athletic match'
    ]),
    WordEntry('Kabaddi', [
      'Raider chanting Kabaddi', 'Cant breathless', 'Touch and return', 'Defense defenders', 'Mat or clay court',
      'Ankle hold tackle', 'Super raid', 'Thirty seconds raid', 'Line crossing', 'Physical strength',
      'Pro Kabaddi league', 'South Asian sport', 'Bonus point', 'Out of court', 'Team tackle',
      'Agility and power', 'Referees whistle', 'Mat combat', 'Traditional sport', 'Body struggle',
      'Tag and run', 'Raid point', 'Defensive chain', 'Sport of toughness', 'Contact sport'
    ]),
    WordEntry('Chess', [
      'Black and white pieces', 'King and Queen', 'Knight horse jump', 'Rook castle', 'Bishop diagonal',
      'Pawn advance', 'Checkmate win', '64 squares board', 'Grandmaster player', 'Clock timer',
      'Strategy game', 'Mind battle', 'Opening gambit', 'Castling move', 'En passant',
      'Tactical thinking', 'Silent focus', 'Board game', 'Mind sport', 'Check threat',
      'Captured piece', 'Calculated move', 'Intellectual match', 'Classic board', 'Master move'
    ]),
    WordEntry('Volleyball', [
      'High net court', 'Spike and block', 'Six team players', 'Serve over net', 'Bump set spike',
      'Rotation order', 'Sand or indoor', 'Volleyball ball', 'Finger tip set', 'Dive save',
      'Point rally', 'Court boundaries', 'Out of bounds', 'Referee stand', 'Fast reflexes',
      'Hand hit', 'Teamwork game', 'Match set', 'Spiker jump', 'Net violation',
      'Court match', 'Beach variant', 'Athletic sport', 'Playful volley', 'Ball game'
    ]),
    WordEntry('Table Tennis', [
      'Small white ball', 'Celluloid ball', 'Wooden paddles', 'Center low net', 'Ping pong sound',
      'Green or blue table', 'Fast spins', 'Table bounce', 'Short rally', 'Serving spin',
      'Reflex speed', 'Indoor room game', 'Edge ball', 'Point game', 'Racket grip',
      'Quick flicks', 'Table top match', 'Smash shot', 'Table boundaries', 'Competitive match',
      'Fast game', 'Paddle sport', 'Spin shots', 'Small ball game', 'Rec room fun'
    ]),
    WordEntry('Swimming', [
      'Water pool', 'Laps and lanes', 'Breaststroke / Freestyle', 'Goggles worn', 'Swim cap',
      'Diving board', 'Water splash', 'Kick and stroke', 'Aquatic sport', 'Pool side',
      'Deep water', 'Floating technique', 'Swim trunks', 'Race timer', 'Flip turn wall',
      'Breath control', 'Pool water', 'Whistle start', 'Water exercise', 'Olympic swimming',
      'Cooling dip', 'Water sport', 'Laps counter', 'Swimmer stroke', 'Pool activity'
    ]),
  ],

  // ─── 8. OCCUPATIONS ─────────────────────────────────────────────────────
  'Occupations': [
    WordEntry('Doctor', [
      'White lab coat', 'Stethoscope around neck', 'Medical degree', 'Prescribes medicine', 'Works in hospital',
      'Heals sick patients', 'Health checkup', 'Clinic consultations', 'Diagnosis expert', 'Surgical gloves',
      'Patient care', 'Emergency treatment', 'Pulse check', 'Medical advice', 'Thermometer check',
      'Health specialist', 'Caring profession', 'Night shifts', 'Life saver', 'Syringe injection',
      'Healthcare provider', 'Medical expert', 'Hospital rounds', 'Clinical practitioner', 'Wellness helper'
    ]),
    WordEntry('Teacher', [
      'Classroom educator', 'Writes on board', 'Grades exam papers', 'Lessons and lectures', 'School or college',
      'Guides students', 'Homework assigned', 'Textbook explanations', 'Chalk and duster', 'Knowledge provider',
      'Class discipline', 'Report card marks', 'Morning roll call', 'Subject specialist', 'Patience and care',
      'School staff', 'Inspiring youth', 'Question answer', 'Learning guide', 'Academic instructor',
      'Education mentor', 'Class teacher', 'School educator', 'Study guide', 'Teaching career'
    ]),
    WordEntry('Police Officer', [
      'Khaki uniform', 'Police badge', 'Station house', 'Patrol car vehicle', 'Handcuffs tool',
      'Law enforcement', 'Traffic control', 'Investigates crimes', 'Whistle blowing', 'Public safety',
      'Night patrol duty', 'FIR report filing', 'Police baton (Lathi)', 'Security keeper', 'Crime solver',
      'Police siren', 'Authority figure', 'Duty for public', 'Checkpoint duty', 'Law keeper',
      'Protector officer', 'Station in charge', 'Police force', 'Uniformed officer', 'Order and law'
    ]),
    WordEntry('Chef / Cook', [
      'Restaurant kitchen', 'Chef white hat (Toque)', 'Master of recipes', 'Cooking meals', 'Sharp kitchen knives',
      'Pan and kadhai', 'Flavor seasoning', 'Delicious dishes', 'Culinary expert', 'Food presentation',
      'Stovetop flames', 'Kitchen team leader', 'Menu creation', 'Tasting sauce', 'Apron worn',
      'Food preparation', 'Gourmet cooking', 'Hot stove work', 'Recipe secrets', 'Food specialist',
      'Kitchen master', 'Cooking career', 'Meal creator', 'Culinary artist', 'Food chef'
    ]),
    WordEntry('Pilot', [
      'Airplane cockpit', 'Captains uniform', 'Flies in sky', 'Flight controls', 'Airline officer',
      'Navigates routes', 'Co-pilot partner', 'Smooth landing', 'Takeoff execution', 'Headset comms',
      'Pre-flight check', 'Aviation expert', 'High altitude work', 'Cabin announcements', 'Wings badge',
      'Flight duty', 'Airport takeoff', 'Cockpit controls', 'Sky navigator', 'Commercial aviator',
      'Air transport', 'Plane captain', 'Flight lead', 'Aviation professional', 'Air pilot'
    ]),
    WordEntry('Driver', [
      'Behind steering wheel', 'Road navigation', 'City traffic', 'Drives vehicle', 'Taxi or bus or auto',
      'Passengers ride', 'Traffic rules', 'Rearview mirror', 'Honking horn', 'Fuel station visits',
      'Drop destination', 'Daily commute worker', 'License holder', 'Street route expert', 'Vehicle maintenance',
      'Safe driving', 'Gear shifting', 'Brake and clutch', 'Transport operator', 'Road worker',
      'Wheel operator', 'Commute driver', 'Route driver', 'Transit worker', 'Driving job'
    ]),
    WordEntry('Farmer / Kisan', [
      'Agricultural fields', 'Crop harvesting', 'Tractor or plow', 'Monsoon rain reliance', 'Grows grains and vegetables',
      'Hard physical labor', 'Early morning work', 'Mud and soil', 'Farmer community', 'Sowing seeds',
      'Organic produce', 'Village farm', 'Irrigation water', 'Crop protection', 'Food grower',
      'Sunlight labor', 'Farming tools', 'Season harvesting', 'Countryside living', 'Land cultivation',
      'Nourishing nation', 'Agricultural worker', 'Green fields', 'Crop worker', 'Essential farmer'
    ]),
    WordEntry('Software Engineer', [
      'Computer screen coding', 'Programming languages', 'Keyboard typing', 'Debugs errors / Bugs', 'Office desk job',
      'Software apps', 'IT company worker', 'Coffee breaks', 'Algorithms and logic', 'Git repositories',
      'Project deadlines', 'Work from home', 'Tech sector', 'Websites and apps', 'Problem solver',
      'Code editor', 'Tech developer', 'Database queries', 'Software updates', 'Engineering mind',
      'Computer programmer', 'Code writer', 'IT engineer', 'Digital builder', 'Tech worker'
    ]),
  ],

  // ─── 9. TECHNOLOGY & GADGETS ────────────────────────────────────────────
  'Technology': [
    WordEntry('Smartphone', [
      'Touchscreen display', 'Pocket device', 'Camera photos', 'Apps download', 'Mobile calls',
      'Wi-Fi and 5G', 'Recharge battery', 'Notifications bell', 'Social media scrolling', 'Text messaging',
      'Screen lock PIN', 'Headphone jack / Bluetooth', 'Everyday gadget', 'Pocket computer', 'Smart features',
      'Charging cable', 'App store', 'Mobile screen', 'Digital device', 'Compact phone',
      'Handheld gadget', 'Tech essential', 'Calling device', 'Phone camera', 'Modern phone'
    ]),
    WordEntry('Laptop', [
      'Folding keyboard screen', 'Trackpad mouse', 'Battery charger', 'Work and study', 'Laptop bag',
      'Processing CPU', 'Webcam lens', 'File storage', 'USB ports', 'Software apps',
      'Portable desk computer', 'Hinged display', 'Keyboard keys', 'Wi-Fi connection', 'Office work',
      'Programming coding', 'Tech device', 'Screen display', 'Digital computer', 'Personal laptop',
      'Computer gadget', 'Workstation unit', 'Tech tool', 'Laptop screen', 'Portable PC'
    ]),
    WordEntry('Earbuds', [
      'Music listening', 'Over ear or in ear', 'Noise cancellation', 'Bluetooth wireless', 'Audio drivers',
      'Sound quality', 'Charging case', 'Sip music solo', 'Podcast listening', 'Headband or buds',
      'Volume level', 'Bass boost', 'Handsfree calls', 'Personal audio', 'Music accessory',
      'Compact audio', 'Ear tips', 'Sound gear', 'Audio gadget', 'Wireless buds',
      'Music gear', 'Sound accessory', 'Listening gadget', 'Private audio', 'Audio tech'
    ]),
    WordEntry('Smartwatch', [
      'Worn on wrist', 'Fitness tracking', 'Heart rate monitor', 'Step counter', 'Digital clock face',
      'App notifications', 'Wireless charging', 'Touch screen face', 'Wrist strap', 'Workout tracker',
      'Sleep tracking', 'Time and date', 'Smart gadget', 'Health metrics', 'Syncs with phone',
      'Water resistant', 'Stylish wristband', 'Wrist computer', 'Digital watch', 'Fitness gear',
      'Tech accessory', 'Wearable device', 'Wrist tracker', 'Smart band', 'Modern watch'
    ]),
    WordEntry('Smart TV', [
      'Living room screen', 'Remote control', 'Streaming apps', 'HDMI ports', 'Wall mounted unit',
      'Big display', 'Movie watching', 'Cable connection', 'Built-in speakers', 'High resolution 4K',
      'Family entertainment', 'Wi-Fi smart features', 'Channel surfing', 'Display panel', 'Home theater',
      'Screen display', 'Video output', 'Home entertainment', 'Living room centerpiece', 'TV screen',
      'Smart device', 'Broadcast receiver', 'Media player', 'Large display', 'Home TV'
    ]),
    WordEntry('Wi-Fi Router', [
      'Wireless internet', 'Antenna signals', 'Modem connection', 'Wi-Fi password', 'Blinking LED lights',
      'Ethernet ports', 'Broadband network', 'Home internet', 'Internet provider', 'Signal strength',
      'Router box', 'Wi-Fi network', 'Data transfer', 'High speed internet', 'Network gateway',
      'Internet hub', 'Connectivity box', 'Wireless signal', 'Router device', 'Network hardware',
      'Wi-Fi box', 'Data router', 'Home network', 'Signal emitter', 'Internet box'
    ]),
    WordEntry('Camera', [
      'Lens optics', 'Shutter button', 'Captures photos', 'Tripod stand', 'Memory card (SD)',
      'Flash light', 'Photographer tool', 'Viewfinder eye', 'Focus ring', 'Video recording',
      'Megapixel resolution', 'Camera strap', 'Picture taking', 'Zoom lens', 'Digital SLR / Mirrorless',
      'Image capture', 'Photo memory', 'Photography gear', 'Optical device', 'Photo camera',
      'Camera device', 'Picture maker', 'Visual capturer', 'Snapshot tool', 'Imaging gear'
    ]),
    WordEntry('Drone', [
      'Quadcopter propellers', 'Remote controller', 'Aerial camera footage', 'Flies in sky', 'GPS navigation',
      'Hovering stability', 'Drone pilot', 'Unmanned flight', 'Battery powered', 'Sky view photos',
      'Compact aircraft', 'Camera drone', 'Drone flight', 'Propeller noise', 'Aerial perspective',
      'Flying camera', 'Sky gadget', 'Tech flyer', 'Remote drone', 'Flying device',
      'Aerial tech', 'Quadcopter drone', 'Sky photographer', 'Drone tech', 'Unmanned flyer'
    ]),
  ],

  // ─── 10. NATURE & WEATHER ───────────────────────────────────────────────
  'Nature': [
    WordEntry('Volcano', [
      'Mountain that erupts', 'Spews hot lava', 'Magma chamber', 'Ash cloud sky', 'Active or dormant',
      'Crater peak', 'Tectonic movement', 'Volcanic rock', 'Extreme heat', 'Molten rock flow',
      'Geological wonder', 'Natural disaster', 'Eruption blast', 'Smoke and fire', 'Volcanic ash',
      'Magma eruption', 'Earth crust break', 'Geothermal energy', 'Volcano mountain', 'Natural hazard',
      'Lava stream', 'Fiery mountain', 'Geology feature', 'Earth eruption', 'Volcanic cone'
    ]),
    WordEntry('Rainbow', [
      'Seven colors (VIBGYOR)', 'Appears after rain', 'Sky arch curve', 'Sunlight through raindrops', 'Prism light refraction',
      'Colorful sky arc', 'Pot of gold myth', 'Nature beauty', 'Rainy day view', 'Bright colors',
      'Sky phenomenon', 'Atmospheric arc', 'Sun and rain combo', 'Beautiful arc', 'Optical display',
      'Colors in sky', 'Colorful band', 'Nature arc', 'Sky spectacle', 'Rainy aftermath',
      'Light spectrum', 'Colorful curve', 'Weather phenomenon', 'Sky arch', 'Natural rainbow'
    ]),
    WordEntry('Waterfall', [
      'Water cascades down', 'River dropping off cliff', 'Splash and mist', 'Natural water feature', 'Roaring water sound',
      'Plunge pool below', 'Scenic nature view', 'Mountain stream', 'Fresh water flow', 'High altitude drop',
      'Scenic spot', 'Water spray', 'Geological cliff', 'Nature waterfall', 'Cascading stream',
      'Water drop', 'Rushing water', 'Scenic cascade', 'Water flow', 'Nature retreat',
      'Hiking destination', 'River fall', 'Cool mist', 'Water cascade', 'Natural drop'
    ]),
    WordEntry('Monsoon Season', [
      'Dark rain clouds', 'Thunderstorm roar', 'Heavy downpour', 'Rainwater streams', 'Umbrella opened',
      'Muddy ground smell', 'Rainy season', 'Soggy streets', 'Waterlogging', 'Cooling weather',
      'Raindrops falling', 'Lightning strikes', 'Puddle water', 'Monsoon clouds', 'Nature shower',
      'Pouring rain', 'Rainstorm weather', 'Wet environment', 'Rainy day', 'Monsoon season',
      'Water deluge', 'Heavy rainfall', 'Stormy sky', 'Rainy weather', 'Downpour rain'
    ]),
    WordEntry('Lightning', [
      'Flash in dark sky', 'Thunder strike', 'Electric spark cloud', 'Stormy night', 'Dangerous bolt',
      'Flashes of light', 'High voltage spark', 'Weather phenomenon', 'Thunderclap sound', 'Tree strike hazard',
      'Nature power', 'Electric bolt', 'Stormy weather', 'Sky flash', 'Instantaneous bright',
      'Loud rumble', 'Atmospheric discharge', 'Storm hazard', 'Lightning bolt', 'Flash of storm',
      'Nature spark', 'Sky strike', 'Fierce lightning', 'Storm flash', 'Nature bolt'
    ]),
    WordEntry('Desert', [
      'Sandy dunes', 'Hot dry climate', 'Camel transport', 'Cactus plants', 'Water oasis',
      'Extremely dry land', 'Sandstorms blowing', 'Scorching sun', 'Low rainfall', 'Barren landscape',
      'Sand hills', 'Night time cold', 'Dry wilderness', 'Arid region', 'Desert sand',
      'Hot climate', 'Dehydration risk', 'Dune landscape', 'Barren terrain', 'Sunbaked ground',
      'Desert sun', 'Endless sand', 'Arid climate', 'Desert trail', 'Dry ecosystem'
    ]),
    WordEntry('Forest / Jungle', [
      'Dense trees', 'Wild animals habitat', 'Green canopy', 'Woodland ecosystem', 'Forest trails',
      'Birds chirping', 'Fresh clean air', 'Fallen leaves', 'Nature forest', 'Deep woods',
      'Wilderness area', 'Tree branches', 'Jungle flora', 'Natural habitat', 'Green foliage',
      'Wildlife haven', 'Forest shade', 'Woodland trees', 'Nature jungle', 'Forest ground',
      'Wild environment', 'Green woods', 'Forest sanctuary', 'Dense greenery', 'Natural forest'
    ]),
    WordEntry('Snowy Mountain', [
      'Cold snow caps', 'High Himalayan altitude', 'White ice peaks', 'Freezing winds', 'Glaciers ice',
      'Snowfall slope', 'Skiing slopes', 'Cold mountain air', 'Majestic heights', 'Summit peak',
      'Rocky ice cliffs', 'Snowy landscape', 'Winter wonderland', 'High elevation', 'Frosty weather',
      'Snowy trails', 'Mountain range', 'Cold climate', 'Glacial peaks', 'White mountain',
      'Alpine region', 'Snowy summit', 'Freezing temperatures', 'Mountain snow', 'High peaks'
    ]),
  ],
};
