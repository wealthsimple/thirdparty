module Thirdparty
  class File < Resource
    def self.create(file:, purpose:)
      response = Request.post("/v1/files", body: {file: file, purpose: purpose})
      new(response)
    end
  end
end
