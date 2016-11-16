# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#t

#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create :name => "example", :email => "example@gmail.com", :password => "123456"

onion = Ingredient.create :name => "onion", :category => "vegetables", :cost => 0.70, :qtyunit => "NOS"

garlic = Ingredient.create :name => "garlic", :category => "vegetables", :cost => 0.20, :qtyunit => "clove"

tumeric_powder = Ingredient.create :name => "tumeric powder", :category => "condiments", :cost => 0.30, :qtyunit => "TBSP"

cream = Ingredient.create :name => "cream", :category => "dairy and eggs", :cost => 0.30, :qtyunit => "100ml"

paneer = Ingredient.create :name => "paneer", :category => "dairy and eggs", :cost => 1.70, :qtyunit => "100g"

ginger = Ingredient.create :name => "ginger", :category => "vegetables", :cost => 0.60, :qtyunit => "100g"

spinach = Ingredient.create :name => "spinach", :category => "vegetables", :cost => 0.50, :qtyunit => "100g"

tomato = Ingredient.create :name => "tomato", :category => "vegetables", :cost => 0.50, :qtyunit => "100g"

basmati_rice = Ingredient.create :name => "basmati rice", :category => "grains", :cost => 0.80, :qtyunit => "100g"

chicken_thigh = Ingredient.create :name => "chicken thigh", :category => "meat", :cost => 1.40, :qtyunit => "100g"

prawns = Ingredient.create :name => "prawns", :category => "seafood", :cost => 3.50, :qtyunit => "100g"

palak_paneer = Recipe.create :name => "Palak Paneer", :cuisine => "Indian", :user_id => 1, :costperserving => 6.7, :views => 50, :instructions => "step 1 do this. step 2 do that. step 3 do this again", :image => "http://photos.vegrecipesofindia.com/wp-content/uploads/2013/05/palak-paneer-recipe.jpg"

chicken_rice = Recipe.create :name => "Chicken Rice", :cuisine => "Malay", :user_id => 1, :costperserving => 2.3, :views => 200, :instructions => "lets do this", :image =>"http://2.bp.blogspot.com/-XlifUsGbe8A/UXQRowm09TI/AAAAAAAABr8/4sLQzVK7S7I/s1600/DSC_5140-Farrari+Steam+Chicken+Rice.jpg"

chicken_pasta = Recipe.create :name => "Chicken Pasta", :cuisine => "Western", :user_id => 1, :costperserving => 3.3, :views => 200, :instructions => "Step 1: Heat 1 1/2 tablespoons of olive oil in a large oven-safe sauté pan over medium-high heat. Add the onions and cook for 3 to 4 minutes, stirring occasionally, until the onions are softened and translucent. Add the minced garlic and cook for 30 seconds. Add crushed tomatoes and cook until the sauce starts bubbling at a rapid simmer, 1 to 2 minutes. Step 2: Reduce heat to low and let the sauce continue slowly simmering for 5 to 7 minutes, stirring occasionally. Mix in honey, parsley, basil and oregano and cook for another minute. Season sauce with salt to your taste. Turn off heat. (Makes 2 1/2 to 3 cups; keeps 4 to 5 days refrigerated or 3 months frozen. Step 3: Bring 2 quarts of water to boil in a pot. Season with a generous pinch of salt. Once the water boils, add pasta and cook for 7 to 9 minutes, depending on how you like your pasta. Drain and run pasta under cold water. Set aside. Step 4: Heat 1 1/2 tablespoons of olive oil in a large skillet over medium-high heat. Add chopped sausage and cook for 5 to 7 minutes, until the meat is cooked through. Add pasta sauce and heat for a minute. Add spinach and fold it into the sauce. The spinach should start wilting in 30 seconds.", :image =>"http://assets.simplyrecipes.com/wp-content/uploads/2016/10/2016-10-10-ChickenSkilletPasta-8.jpg"

mexican_spaghetti = Recipe.create :name => "Mexican-Style Spaghetti and Meatballs", :cuisine => "Western", :user_id => 1, :costperserving => 4.3, :views => 100, :instructions => "Step 1: Preheat an oven to 350 degrees F (175 degrees C). Place a sheet of aluminum foil onto a baking sheet, and lightly grease with cooking spray. Step 2: Place the ground turkey into a large mixing bowl and sprinkle with the Mexican chili powder, guajillo chile powder, salt, black pepper, and Parmesan cheese. Add the egg, olive oil, chopped onion, jalapeno pepper, and Anaheim pepper. Mix well with your hands until evenly blended, then sprinkle with the tostada crumbs and bread crumbs. Mix again until the bread crumbs are incorporated. Form the meatball mixture into 1-inch balls and place onto the prepared baking sheet. Step 3: Bake in the preheated oven until the meatballs have lightly browned and are no longer pink in the center, about 40 minutes. Turn the meatballs over after 20 minutes to ensure even cooking. Step 4: Fill a large pot with lightly salted water and bring to a rolling boil over high heat. Once the water is boiling, stir in the spaghetti and return to a boil. Cook the pasta uncovered, stirring occasionally, until the pasta has cooked through, but is still firm to the bite, about 12 minutes. Drain well in a colander set in the sink.", :image =>"http://images.media-allrecipes.com/userphotos/560x315/647849.jpg"

chinese_spareribs = Recipe.create :name => "Chinese Spareribs", :cuisine => "Chinese", :user_id => 1, :costperserving => 3.3, :views => 230, :instructions => "Step 1: In a shallow glass dish, mix together the hoisin sauce, ketchup, honey, soy sauce, sake, rice vinegar, lemon juice, ginger, garlic and five-spice powder. Place the ribs in the dish, and turn to coat. Cover and marinate in the refrigerator for 2 hours, or as long as overnight. Step 2: Preheat the oven to 325 degrees F (165 degrees C). Fill a broiler tray with enough water to cover the bottom. Place the grate or rack over the tray. Arrange the ribs on the grate. Step 3: Place the broiler rack in the center of the oven. Cook for 40 minutes, turning and brushing with the marinade every 10 minutes. Let the marinade cook on for the final 10 minutes to make a glaze. Finish under the broiler if desired. Discard any remaining marinade.", :image =>"http://images.media-allrecipes.com/userphotos/560x315/868083.jpg"

chinese_peppersteak = Recipe.create :name => "Chinese Pepper Stick", :cuisine => "Chinese", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1: Heat the oil in a saucepan over medium heat. Add the cumin seeds, ginger, cayenne pepper, fennel seeds, asafoetida powder, and garam masala; cook and stir for about 2 minutes to release the flavors. Step 2: Preheat the oven to 325 degrees F (165 degrees C). Fill a broiler tray with enough water to cover the bottom. Place the grate or rack over the tray. Arrange the ribs on the grate. Step 3: Place the broiler rack in the center of the oven. Cook for 40 minutes, turning and brushing with the marinade every 10 minutes. Let the marinade cook on for the final 10 minutes to make a glaze. Finish under the broiler if desired. Discard any remaining marinade.", :image =>"http://images.media-allrecipes.com/userphotos/560x315/1114848.jpg"

malaysian_laksa = Recipe.create :name => "Malaysian laksa", :cuisine => "Malay", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1:
Place noodles in a large heatproof bowl. Cover with boiling water. Stand for 4 to 5 minutes or until just tender. Using a fork, separate noodles. Drain. Step 2: Meanwhile, heat a saucepan over medium-high heat. Cook laksa paste, stirring, for 1 minute or until fragrant. Add onion. Cook, stirring, for 2 minutes or until softened. Stir in stock and 1 cup cold water. Add lime leaves. Cover. Bring to the boil. Simmer for 5 minutes. Step 3:
Add chicken. Cook for 5 to 10 minutes or until heated through. Remove from heat. Remove and discard lime leaves. Stir in coconut milk. Divide noodles between bowls. Ladle over stock mixture. Top with beansprouts, chilli, cucumber, pineapple and coriander. Serve with lime halves.", :image =>"http://www.taste.com.au/images/recipes/sfi/2010/02/malaysian-laksa-19216_l.jpeg"

ayam_goreng = Recipe.create :name => "Ayam Goreng", :cuisine => "Malay", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1: Rinse chicken inside and out under cold running water. Pat dry with paper towel. Place chicken, breast-side down, on a work surface. Use poultry shears or sharp kitchen scissors to cut along either side of the backbone. Discard the backbone. Cut the breast in half along the breastbone. Cut around the legs, between the thigh and breast. Cut drumsticks from the thighs. Cut the wings from the breasts. Cut each breast in half diagonally. Step 2: Combine water, coconut milk, onion, garlic, bay leaves, lemon grass, sugar and turmeric in a large saucepan. Add the chicken. Bring to a simmer over medium-high heat. Reduce heat to medium and cook for 50 minutes or until chicken is cooked through. Transfer the chicken to a bowl. Set aside to cool. Discard the coconut milk mixture. Step 3: Line a baking tray with paper towel. Place flour in a bowl. Season with salt and white pepper. Toss chicken in the flour to coat. Add enough oil to a large heavy-based saucepan to reach a depth of 10cm. Heat to 180°C over medium-high heat (when oil is ready a cube of bread turns golden-brown in 15 seconds). Add one-third of chicken. Cook for 4 minutes or until golden. Transfer to lined tray. Cook the remaining chicken, in 2 more batches, reheating oil between batches.", :image =>"http://www.taste.com.au/images/recipes/agt/2010/03/ayam-goring-fried-chicken-19284_l.jpeg"

penang_curry = Recipe.create :name => "Penang Curry", :cuisine => "Malay", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1:
Combine curry paste and peanuts in a bowl. Heat wok over medium heat until hot. Spoon thick top layer of coconut cream into wok (see note). Cook, stirring, for 8 to 10 minutes or until oil separates and floats to the top. Add curry paste mixture. Cook, stirring, for 2 minutes. Add sugar and fish sauce. Cook for 5 minutes or until sauce reduces slightly. Gradually add remaining coconut cream and stock. Cook for 15 to 20 minutes or until sauce thickens. Step 2:
Meanwhile, heat a chargrill or frying pan over medium-high heat. Brush both sides of beef with oil. Cook for 3 minutes each side for medium or until cooked to your liking. Transfer to a plate. Cover and allow to rest for 5 minutes. Slice into thin strips. Step 3:
Add beef, kaffir lime and basil to curry and stir to combine. Spoon curry over rice. Top with chillies and serve.", :image =>"http://www.taste.com.au/images/recipes/sfi/2007/03/penang-curry-11875_l.jpeg"

indian_platter = Recipe.create :name => "Indian Platter", :cuisine => "Indian", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1: Preheat oven to 200°C. Combine lamb and tandoori paste in a ceramic bowl. Cover and refrigerate for 30 minutes, if time permits. Step 2:
Meanwhile, place naan on a large baking tray. Brush with eggwhite. Sprinkle with half the onion. Bake for 15 minutes or until crisp. Tear into pieces. Step 3:
Heat oil in a non-stick frying pan over medium-high heat. Cook lamb for 4 minutes each side for medium or until cooked to your liking. Remove to a plate. Cover loosely with foil. Set aside for 10 minutes. Thinly slice. Step 4:
Meanwhile, combine chutney, yoghurt, 1 tablespoon lemon juice and 1 tablespoon coriander in a bowl. Combine tomatoes, cucumber, remaining lemon juice, remaining coriander and remaining onion in a separate bowl. Step 5:
Arrange lamb, naan, chutney mixture and tomato mixture on a large platter. Serve.", :image =>"http://www.taste.com.au/images/recipes/sfi/2007/12/indian-platter-13562_l.jpeg"

southindian_bowl = Recipe.create :name => "South Indian Bowl", :cuisine => "Indian", :user_id => 1, :costperserving => 4.3, :views => 131, :instructions => "Step 1:
Preheat oven to 200C or 180C fan-force. Line an oven tray with baking paper. Place cauliflower, vegetable oil and turmeric in a large bowl. Season and toss to coat. Arrange on prepared tray in a single layer. Roast for 25 minutes. Step 2:
Meanwhile, cook beans in a small saucepan of boiling salted water for 3 minutes or until tender. Drain and return to pan to keep warm. Step 3:
Meanwhile, heat coconut oil in a large frying pan. Cook mustard seeds for 1 minute or until they start to pop. Add onion, curry leaves and cumin seeds and cook, stirring, for 5 minutes or until onion softens. Add half of onion mixture to beans. Add carrot and coconut to large pan and cook, stirring, over medium heat for 1-2 minutes or until carrot is bright orange. Add lemon juice and toss to coat. Step 4:
Meanwhile, lightly spray a frying pan with oil and heat over medium-high. Cook paneer, tossing for 3-4 minutes or until golden.", :image =>"http://www.taste.com.au/images/recipes/tas/2015/08/south-indian-bowl-32809_l.jpeg"



1.upto(9) do |i|
 Recipe.find(1).recipe_ingredients.create ingredient_id:i, quantity:rand(1..5)
end
