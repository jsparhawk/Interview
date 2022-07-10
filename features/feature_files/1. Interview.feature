Feature: Registration mark validation

  As a Service Designer
  I want to ensure the Registration mark is valid
  So that only valid Registration marks can be registered


  Scenario Outline: Registration mark format

    Given I have a <registration mark>
    When the format is valid
    Then I can register a vehicle

    Examples: Valid Format
      | registration mark |
      | AA01AAA           |
      | BB51BBB           |
      | YY99YYY           |

    Examples: Invalid Format
      | registration mark |
      | aa51aaa           |
      | BD51AA            |
      | BD513AA           |

    Examples: Invalid region I,J,Q,T,U,Z
      | registration mark |
      | ZD51SMR           |
      | JD51SMR           |
      | TD51SMR           |

    Examples: Invalid area code I,Q
      | registration mark |
      | BI51SMR           |
      | BQ51SMR           |


  Scenario Outline: Check year of registration

    Given I have a <registration mark>
    When the year of registration is valid
    Then I can register a vehicle

    Examples: Valid age identifier
      | registration mark |
      | AA09AAA           |
      | AA71AAA           |
      | AA22AAA           |

    Examples: Invalid age identifier
      | registration mark |
      | AA00AAA           |
      | AA23AAA           |
      | AA72AAA           |
