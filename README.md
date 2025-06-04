# User API

A Ruby on Rails API service that provides user management functionality with simulated random failures for testing purposes.

## Tech Stack

- Ruby: ruby 3.4.1
- Rails: Rails 8.0.2
- Database: PostgreSQL
- Testing: Minitest

## Features

### 1. UUID Generation
**Endpoint:** `GET /id`
- Returns a universally unique identifier (UUID)
- Response time: < 50ms
- Response Format:
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000"
  }
  ```

### 2. Random User Retrieval
**Endpoint:** `GET /user`
- Returns a random user's details from the database
- Response time: ~300ms
- Response Format:
  ```json
  {
    "id": "123e4567-e89b-12d3-a456-426614174000",
    "name": "John Doe",
    "biography": "Software engineer...",
    "created_at": "2024-01-01T12:00:00.000Z",
    "updated_at": "2024-01-01T12:00:00.000Z"
  }
  ```

### 3. User Creation (with Simulated Failures)
**Endpoint:** `POST /user`
- Creates a new user with 50% chance of success/failure
- Validates presence of name and biography
- Response time: Variable

**Request Format:**
```json
{
  "name": "John Doe",
  "biography": "A software engineer..."
}
```

**Success Response (200 OK):**
```json
{
  "id": "123e4567-e89b-12d3-a456-426614174000",
  "name": "John Doe",
  "biography": "A software engineer...",
  "created_at": "2024-01-01T12:00:00.000Z",
  "updated_at": "2024-01-01T12:00:00.000Z"
}
```

**Failure Responses:**
1. Random Failure (422 Unprocessable Entity):
```json
{
  "error": "Failed to save user (random failure simulation)"
}
```

2. Validation Failure (422 Unprocessable Entity):
```json
{
  "errors": {
    "name": ["can't be blank"],
    "biography": ["can't be blank"]
  }
}
```

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd user_api
```

2. Install dependencies:
```bash
bundle install
```

3. Database setup:
```bash
bin/rails db:create db:migrate
bin/rails db:seed  # Optional: Adds sample users
```

4. Run the server:
```bash
bin/rails server
```

## Testing

Run the test suite:
```bash
bin/rails test
```

### Example API Calls

1. Get a UUID:
```bash
curl http://localhost:3000/id
```

2. Get a random user:
```bash
curl http://localhost:3000/user
```

3. Create a new user:
```bash
curl -X POST http://localhost:3000/user \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "biography": "A software engineer..."}'
```

## CI/CD

The project includes GitHub Actions workflows for:
- Automated testing
- Code linting (RuboCop)
- Security scanning (Brakeman)

## Development

- The application uses UUID for primary keys
- Includes comprehensive test coverage
- Follows Rails API-only configuration
- Implements proper error handling
