# Travel Weather

### Description 
  Travel weather is a rails API created for consumption by a front-end team. Travel weather has five core endpoints that provide information about weather forecasts as well as travel information. 
  
### Ruby/Rails Versions
  - Ruby: 2.7.2
  - Rails: 5.2.6

### Local Deployment
  For local deployment, run the following commands from the command line
  ```
    git clone git@github.com:acmassey3698/travel-weather.git
    
    bundle install
    
    rake db:{drop,create,migrate}
    
    bundle exec figaro install
  ```
  The final command will create `config/application.yml`. This file is not committed in git tracking and can be used to store sensitive data(api keys)
  
  Local deployment of this application is dependent on external APIs that require authorization. The documentation for those APIs can be found at the following sites
  - [OpenWeather API](https://openweathermap.org/api)
  - [MapQuest API](https://developer.mapquest.com/documentation/)
  - [Unsplash API](https://unsplash.com/developers)

Once all three keys have been created, they can be added to the `config/application.yml` file following this format 
```
OPEN_WEATHER_API_KEY: <your key>
MAPQUEST_API_KEY: <your key>
UNSPLASH_API_KEY: <your key>
```

### Running the Test Suite
The RSpec test suite can be run using the command 
```
bundle exec rspec
```

### Running the Server
To run the server for local endpoint testing (i.e. Postman)
```
rails s
```

### API Endpoints 
- Base url: `http://localhost:3000/api/v1`

<details>
  
  <summary>Get Weather for a City</summary>
  
  * method: GET
  
  * endpoint: `/forecast`
  
  * required params: location: string (ex: Denver,CO)
  
  * example request: `GET http://localhost:3000/api/v1/forecast?location=denver,co`
  
  * example response:
  
  ```
  {
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "Tue Nov 16 21:40:26 2021",
                "sunrise": "Tue Nov 16 13:46:09 2021",
                "sunset": "Tue Nov 16 23:43:41 2021",
                "temperature": 68.5,
                "feels_like": 65.77,
                "humidity": 15,
                "uvi": 0.65,
                "visibility": 10000,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "Wed Nov 17 2021",
                    "sunrise": "Wed Nov 17 13:47:17 2021",
                    "sunset": "Wed Nov 17 23:42:57 2021",
                    "max_temp": 42.98,
                    "min_temp": 34.63,
                    "conditions": "broken clouds",
                    "icon": "04d"
                },
                {
                    "date": "Thu Nov 18 2021",
                    "sunrise": "Thu Nov 18 13:48:26 2021",
                    "sunset": "Thu Nov 18 23:42:16 2021",
                    "max_temp": 49.24,
                    "min_temp": 32.27,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "Fri Nov 19 2021",
                    "sunrise": "Fri Nov 19 13:49:34 2021",
                    "sunset": "Fri Nov 19 23:41:36 2021",
                    "max_temp": 61.65,
                    "min_temp": 43.93,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "Sat Nov 20 2021",
                    "sunrise": "Sat Nov 20 13:50:41 2021",
                    "sunset": "Sat Nov 20 23:40:58 2021",
                    "max_temp": 58.75,
                    "min_temp": 44.8,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "Sun Nov 21 2021",
                    "sunrise": "Sun Nov 21 13:51:48 2021",
                    "sunset": "Sun Nov 21 23:40:22 2021",
                    "max_temp": 58.89,
                    "min_temp": 30.79,
                    "conditions": "broken clouds",
                    "icon": "04d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "22:00:00",
                    "temperature": 68.5,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "23:00:00",
                    "temperature": 67.57,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "00:00:00",
                    "temperature": 65.35,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "01:00:00",
                    "temperature": 62.6,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "02:00:00",
                    "temperature": 59.41,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "03:00:00",
                    "temperature": 55.26,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "04:00:00",
                    "temperature": 53.19,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                },
                {
                    "time": "05:00:00",
                    "temperature": 48.88,
                    "conditions": "few clouds",
                    "icon": "02n"
                }
            ]
        }
    }
}
  ```
</details>

<details>
  <summary>Background Image for a City</summary>
  
  * method: GET
  
  * endpoint: `/background`
  
  * required params: location: string (ex: Denver,CO)
  
  * example request: `GET http://localhost:3000/api/v1/background?location=denver,co`
  
  * example response:
  
  ```
  {
    "data": {
        "type": "image",
        "id": null,
        "attributes": {
            "image": {
                "location": "denver,co",
                "image_url": "https://images.unsplash.com/photo-1511286148006-ec48824e3282?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyNzU1NzV8MHwxfHNlYXJjaHwxfHxkZW52ZXIlMkNjb3NreWxpbmV8ZW58MHx8fHwxNjM3MDkyNjc1&ixlib=rb-1.2.1&q=80&w=1080",
                "credit": {
                    "author": "mirandafayj",
                    "profile": "https://api.unsplash.com/users/mirandafayj"
                }
            }
        }
    }
}
  
  ```  
</details>

<details>
  <summary>Create a New User</summary>
  
  * method: POST
  
  * endpoint: `/users`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - email: string
    
    - password: string 
  
    - password_confirmation: string
  
  * example request: `POST http://localhost:3000/api/v1/users`
  
  * example response:
  
  ```
  {
    "data": {
        "type": "users",
        "id": "4",
        "attributes": {
            "email": "alx@alex.com",
            "api_key": "33565062c1b85dbda984641d0a639da1"
        }
    }
}
  ```  
</details>


<details>
  <summary>Login as Existing User</summary>
    
  * method: POST
  
  * endpoint: `/sessions`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - email: string
    
    - password: string 
  
  * example request: `POST http://localhost:3000/api/v1/sessions`
  
  * example response:
  
  ```
  {
    "data": {
        "type": "users",
        "id": "4",
        "attributes": {
            "email": "alx@alex.com",
            "api_key": "33565062c1b85dbda984641d0a639da1"
        }
    }
}
  ```     
</details>

<details>
  <summary>Create a Road Trip</summary>
    
  * method: POST
  
  * endpoint: `/road_trip`
  
  * required params: MUST BE SENT AS JSON PAYLOAD IN BODY OF REQUEST
    
    - origin: string (ex: Denver,CO
    
    - destination: string (ex: Rifle,CO)
  
    - api_key: string
  
  * example request: `POST http://localhost:3000/api/v1/road_trip`
  
  * example response:
  
  ```
 {
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Rifle,CO",
            "travel_time": "02:53:58",
            "weather_at_eta": {
                "temperature": 55.04,
                "conditions": "overcast clouds"
            }
        }
    }
}
  ```   
</details>

### Contact Info
### Contact Info 
  
  ![Linked In](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)
- [Andrew Massey](https://www.linkedin.com/in/andrew-massey-b06662194/)


![Github](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)
- [Andrew Massey](https://github.com/acmassey3698)
