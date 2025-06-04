Camille.configure do |config|
  # Configure the output directory for generated TypeScript files
  config.typescript.output_path = "../frontend/src/api"

  # Configure the base URL for API endpoints
  config.typescript.base_url = "http://localhost:3000"

  # Configure the API endpoints to generate clients for
  config.typescript.endpoints = [
    {
      path: "/user",
      methods: [ :get, :post ],
      description: "User endpoints for random user retrieval and creation"
    },
    {
      path: "/id",
      methods: [ :get ],
      description: "UUID generation endpoint"
    }
  ]

  # Configure TypeScript types for our models
  config.typescript.types = {
    User: {
      id: :string,
      name: :string,
      biography: :string,
      created_at: :string,
      updated_at: :string
    }
  }
end
