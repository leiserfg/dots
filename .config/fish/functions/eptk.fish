# Defined in /tmp/fish.2tgjlU/eptk.fish @ line 2
function eptk --description alias\ eptk\ export\ EP_ACCESS_TK=\(curl\ \'https://bestshopever.beyondshop.cloud/api/oauth/token\'\ \ -u\ \'6e321b88-00aa-4435-8393-e6346955f82d:npc4gr9q90vkg05ejrg5sjgnnn\'\ -X\ POST\ -d\ \'grant_type=authorization_code\&code=8NJOH7\'\ \|jq\ .access_token\)
	export EP_ACCESS_TK=(curl 'https://bestshopever.beyondshop.cloud/api/oauth/token'  -u '6e321b88-00aa-4435-8393-e6346955f82d:npc4gr9q90vkg05ejrg5sjgnnn' -X POST -d 'grant_type=authorization_code&code=8NJOH7' |jq .access_token|sed 's/"//g')
end
