test_cases = [{:first_name=>"",
:last_name=>"Test user",
:username=>"Pandabean18",
:password=>"askdfbwsefhb",
:mail=>"testUsermail@gmail.com",
:phone=>9876543210,
:admin=>false},
{:first_name=>"Test",
:last_name=>"User",
:username=>"",
:password=>"TestUser2pass",
:mail=>"testUser2mail@gmail.com",
:phone=>9876543210,
:admin=>true},
{:first_name=>"Test",
:last_name=>"User 3",
:username=>"TestUser3",
:password=>"",
:mail=>"testUser2mail@gmail.com",
:phone=>9876543210,
:admin=>true},
{:first_name=>"Test",
:last_name=>"User 4",
:username=>"TestUser4",
:password=>"TestUser4Pass",
:mail=>"",
:phone=>9876543210,
:admin=>true},
{:first_name=>"Test",
:last_name=>"User 4",
:username=>"TestUser4",
:password=>"TestUser4Pass",
:mail=>"randomassmaillol",
:phone=>9876543210,
:admin=>true}]

passed_cases = []
test_cases.each do |test_case| 
    user = User.new(test_case)
    if !(user.save)
        puts user.errors.full_messages
    else
        passed_cases << user 
    end
end

puts passed_cases