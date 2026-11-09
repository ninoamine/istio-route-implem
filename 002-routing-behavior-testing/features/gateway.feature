Feature: Routing across environments

  @prod
  Scenario: Production routes /api-prod to the production backend
    Given the manifests for "prod"
    When I trace the hostname "shop.example.com"
    Then the hostname should be found
    And route 1 field "resource.kind" should equal "HTTPRoute"
    And rule 1 of route 1 should match path prefix "/api-prod"
    And rule 1 of route 1 should send traffic to service "api-prod" on port 8080
    And destination 1 of rule 1 of route 1 field "weight" should equal "100"

  @prod
  Scenario: Production has no routing problems
    When I trace the hostname "shop.example.com"
    Then the hostname should be found
    And there should be no findings with severity "error"