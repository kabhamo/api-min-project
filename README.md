# Rails Rest API
Mhamed-Efi
[![Build Status](https://travis-ci.org/YuKitAs/rails-rest-api.svg?branch=master)](https://travis-ci.org/YuKitAs/rails-rest-api)

## Project Setup

**Install all gems**:

```console
$ bundle install
```

**(Important!)Update the database with new data model**:

```console
$ rails db:drop:_unsafe
```


```console
$ rake db:migrate
```

**Feed the database with default seeds**:

```console
$ rake db:seed
```

**Start the web server on `http://localhost:3000` by default**:

```console
$ rails server
```

## PEOPLE ROUTES

| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| GET | api/people/| |
| GET | api/people/:person_id   | |
| GET | api/people/:person_id/tasks    | |
| POST | api/people/ |  |
| POST | api/people/:person_id/tasks |  |
| DELETE | api/people/:person_id |  |
| PATCH | api/people/:person_id |  |


## TASKS ROUTES

| HTTP verbs | Paths  | Used for |
| ---------- | ------ | --------:|
| GET | api/tasks/:id | |
| GET | api/tasks/:id/status | |
| GET | api/tasks/:id/owner | |
| PATCH | api/tasks/:id |  |
| PUT | api/tasks/:id/status |  |
| PUT | api/tasks/:id/owner |  |
| DELETE | api/tasks/:id |  |

## Use Case Examples
