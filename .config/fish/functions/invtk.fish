# Defined in /tmp/fish.lwsM9P/invtk.fish @ line 2
function invtk
	export INV_TK=(curl -X POST   https://app.inventorum.com/api/api-auth-token/ \
    -H "Accept: application/json" \
    -H "Content-Type: application/json" \
    -d '{   "email":"gm+dev3@inventorum.com",   "password":"Epages2018" }'| jq -r .token)
end
