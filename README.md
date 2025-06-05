# User API

A Ruby on Rails API service that provides user management functionality with simulated random failures for testing purposes.

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Ruby**:
   - Required version: 3.4.1
   - Installation guides:
     - macOS: Use [rbenv](https://github.com/rbenv/rbenv#installation) or [RVM](https://rvm.io/rvm/install)
     - Windows: Use [RubyInstaller](https://rubyinstaller.org/)
     - Linux: Use [rbenv](https://github.com/rbenv/rbenv#installation) or package manager

2. **PostgreSQL**:
   - Required version: 14.0 or higher
   - Installation guides:
     - macOS: `brew install postgresql@14` or [Postgres.app](https://postgresapp.com/)
     - Windows: [PostgreSQL Installer](https://www.postgresql.org/download/windows/)
     - Linux: `sudo apt-get install postgresql` or equivalent

3. **Node.js and npm** (for frontend development):
   - Required version: Node.js 18+ and npm 9+
   - Installation: [Download from official site](https://nodejs.org/)

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
    "biography": "Software engineer..."
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

⚠️ **Important**: Please check all [Prerequisites](#prerequisites) are installed before proceeding.

1. **Install Ruby** (if not already installed):
   ```bash
   # Using rbenv on macOS/Linux:
   rbenv install 3.4.1
   rbenv global 3.4.1
   
   # Verify installation:
   ruby -v
   ```

2. **Install Rails and Bundler**:
   ```bash
   gem install rails -v 8.0.2
   gem install bundler
   ```

3. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd user_api
   ```

4. **Install project dependencies**:
   ```bash
   bundle install
   ```

5. **Set up PostgreSQL**:
   ```bash
   # Start PostgreSQL service
   # On macOS:
   brew services start postgresql@14
   # On Linux:
   sudo service postgresql start
   # On Windows:
   # Use Task Manager or Services app
   ```

6. **Configure database**:
   ```bash
   # Copy and edit database configuration if needed
   cp config/database.yml.example config/database.yml
   ```

7. **Database setup**:
   ```bash
   # For first-time setup:
   bin/rails db:create db:migrate db:seed

   # For resetting existing database:
   bin/rails db:reset
   ```

8. **Run the server**:
   ```bash
   bin/rails server
   ```

## Troubleshooting

Common issues and solutions:

1. **PostgreSQL connection errors**:
   - Ensure PostgreSQL is running
   - Check database.yml configuration
   - Verify PostgreSQL user permissions

2. **Ruby version mismatch**:
   - Use rbenv or RVM to install and select correct version
   - Run `rbenv rehash` after installing gems

3. **Bundle install fails**:
   - Run `gem install pg` if PostgreSQL gem fails
   - Install required system libraries:
     ```bash
     # Ubuntu/Debian:
     sudo apt-get install libpq-dev
     # macOS:
     brew install postgresql
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
- Uses Github Actions CI/CD
- Follows Rails API-only configuration
- Implements proper error handling
