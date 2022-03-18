'Each challenge comes with their pre-defined variable, candidates have to use these variables and are not allowed to modify them.'

######################################################################################
  'Challenge 1: String scrubbing
    The paragraph given below contains special characters that are usually the 
    source of great evil that distrupts subsequent functions if left untreated.
    Write a method to cleanse the paragraph of non-alpha numeric characters,
    and make them all lowercase and trimmed'

    paragraph = "Grant me the ’S3R3NITY’ to accept the things I cannot change –
                  The ’C0URAGE’ to change the things I can –
                    And the ’W1SD0M’ to know the difference"

    expected_answer = "grant me the s3r3nity to accept the things i cannot change the c0urage to change the things i can and the w1sd0m to know the difference"

    #remove non-alphanumerics and trim spaces
    #notably apostrophes turn into spaces ("it's"->"it s")
    def sanitize_paragraph(paragraph)
      return paragraph.downcase.scan(/[0-9a-z]+/).join(" ")
    end

    puts "Challenge 1 completed: #{sanitize_paragraph(paragraph) == expected_answer}"

#####################################################################################
  'Challenge 2: Substring extraction
    Given the following array of address string, extract each of their state. Your solution should accomodate all of the cases'

    addresses = [
      "SIBU - JALAN JERRWIT TIMUR, Jalan Jerrwit Timur, Sibu, Sarawak",
      "KAMPUNG KUBUR SHARIF, Bukit Rakit, Kuala Terengganu, Terengganu Darul Iman",
      "Persiaran Laksamana, Puteri Harbour, 79250, Johor",
      "LOT PT 6458, Kuala Berang, Hulu Terengganu, Terengganu",
      "PANGSAPURI CEMPAKA,Bandar Bukit Puchong, 47100 Puchong, Selangor Darul Ehsan",
      "OASIS ARA DAMANSARA, JALAN PJU 7A/1A, ARA DAMANSARA, 47301 PJ, SELANGOR, MALAYSIA",
    ]

    expected_answer = [
      "SARAWAK", "TERENGGANU", "JOHOR", "TERENGGANU", "SELANGOR", "SELANGOR"
    ]

    #find the state information from the address string using a word search
    def get_state(address)
      states = ["JOHOR","KEDAH","KELANTAN","MALACCA","NEGERI","SEMBILAN","PAHANG","PERAK","PERLIS","SABAH","SARAWAK","SELANGOR","TERENGGANU"]
      states.each { |s|
        if address.upcase.scan(/\w+/).include?(s)
          return s
        end
      }
    end

    # passing validation
    addresses.each_with_index do |address, index|
      puts "Challenge 2-#{index+1} completed: #{get_state(address) == expected_answer[index]}"
    end

#####################################################################################
  'Challenge 3: Parsing
    Given the following array of coordinate, convert it into Well-Known Text (WKT) format.
    Wiki link on WKT and its format: https://en.wikipedia.org/wiki/Well-known_text_representation_of_geometry
    Hint: recursion might be a friend here'

    coordinate_pair = [[[[30,20], [45,40], [10,40], [30,20]]], [[[15,5], [40,10], [10,20], [5,10], [15,5]]]]
    expected_answer = "MULTIPOLYGON (((30 20, 45 40, 10 40, 30 20)), ((15 5, 40 10, 10 20, 5 10, 15 5)))"

    #constructs a WKT string using recursion
    def recursive_coordinate_walk(coordinate_pair)
      output = ""
      coordinate_pair.each_with_index do |node, index|
        if node[0].is_a?(Array) #outer arrays get parentheses
          output.concat("(",recursive_coordinate_walk(node),")")
        elsif node.is_a?(Array) #innermost arrays containing only numbers are adjusted accordingly
          output.concat(coordinate_pair.map{|pair| pair.join(" ")}.join(", "))
          break
        end
        if index != coordinate_pair.size-1 #separation
            output.concat(", ")
        end
      end
      return output
    end
    
    #adding the finishing touches
    #text has to be added manually because the information cannot be obtained from just the coordinates
    #for example, LINESTRING and MULTIPOINT can be indistinguishable without text
    def coord_to_wkt(coordinate_pair)
      return "MULTIPOLYGON (#{recursive_coordinate_walk(coordinate_pair)})"
    end

    # passing validation
    puts "Challenge 3 completed: #{coord_to_wkt(coordinate_pair) == expected_answer}"

#####################################################################################
  'Challenge 4: is_palindrome?
    Palindrome is a sequence of characer that reads the same backward as it is forward, eg: 
    KAYAK when spelled in reverse is still KAYAK; MADAM, RACECAR etc.

    Write a method that accepts a string & returns true or false depending on 
    whether the input is a palindrome or not.

    Bonus points for the elegant recursive solution!'

    def is_palindrome?(word)
      return word.empty? || (word[-1] == word[0] && (word[1,-2] == nil || is_palindrome?(word[1,-2])))
    end

    # passing validation
    puts "Challenge 4-1: is 'RADAR' a palindrome? Output: #{is_palindrome?('RADAR').to_s || "nil"} | Correct answer: true"
    puts "Challenge 4-2: is '2121' a palindrome? Output: #{is_palindrome?('2121').to_s || "nil"} | Correct answer: false"
    puts "Challenge 4-3: is 'x' a palindrome? Output: #{is_palindrome?('x').to_s || "nil"} | Correct answer: true"
