# Saikou API

This API allows you to access international music chart data in one place. Check out a demo [here](https://saikou.herokuapp.com/).

API Base URL: https://saikou-api.herokuapp.com/

As of right now, there are no auth credentials. In the near future, API keys will be added. 

## Endpoints

```
GET /api/v1/years/:year_number/weeks/:weeks_number/songs
```
Returns number one hit songs for all countries/charts on a given week within a year. 

### Examples

```
resp = conn.get("/api/v1/years/2014/weeks/48/songs")

resp.status # => 200

resp.body
  #   => {"countries":[{"name":"United States","charts":[{"name":"Billboard","song":{"name":"Blank Space","artist":"Taylor Swift"}}]},
  #      {"name":"United Kingdom","charts":[{"name":"Official Charts","song":{"name":"THESE DAYS","artist":"TAKE THAT"}}]}]}


resp = conn.get("/api/v1/years/3000/weeks/0/songs")

resp.status # => 404

resp.body 
  #   => {"message": "Resource not found"}



