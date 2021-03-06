Feature: Record current command info
  
  Scenario: Record commands to copy lines
    When I insert:
    """
    This is the start of text -1 -1 -1 t t t f f f k k k
    This is the second line -1 -1 -1 t t t f f f k k k
    This is the third line -1 -1 -1 t t t f f f k k k
    """
    And I go to the beginning of buffer
    Given I have at least one cursor
    Then these examples should pass:
    | keys | command   |
    | yy   | evil-yank |
    | 3yy  | evil-yank |
    | yw   | evil-yank |
    | ye   | evil-yank |
    | 3yw  | evil-yank |
    | yt-  | evil-yank |
    | ytk  | evil-yank |
    | 3yt- | evil-yank |
    | ytt  | evil-yank |
    | yff  | evil-yank |
    | 2ytt | evil-yank |
    | 2yff | evil-yank |
    
  Scenario: Record commands to change lines
    When I insert:
    """
    This is the start of text -1 -1 -1 t t t f f f k k k
    This is the second line -1 -1 -1 t t t f f f k k k
    This is the third line -1 -1 -1 t t t f f f k k k
    """
    And I go to the beginning of buffer
    Given I have at least one cursor
    And The cursors are frozen
    Then These examples with undo should pass:
    | keys | command     |
    | cc   | evil-change |
    | ctk  | evil-change |
    | cfk  | evil-change |
    | ctt  | evil-change |
    | cff  | evil-change |
    | 3ctk | evil-change |
    | 3cfk | evil-change |
    | 3ctt | evil-change |
    | 3cff | evil-change |
    | 3cc  | evil-change |

  Scenario: Record commands to delete lines
    When I insert:
    """
    This is the start of text -1 -1 -1 t t t f f f k k k
    This is the second line -1 -1 -1 t t t f f f k k k
    This is the third line -1 -1 -1 t t t f f f k k k
    """
    And I go to the beginning of buffer
    Given I have at least one cursor
    And The cursors are frozen
    Then These examples with undo should pass:
    | keys | command     |
    | dd   | evil-delete |
    | dtk  | evil-delete |
    | dfk  | evil-delete |
    | dtt  | evil-delete |
    | dff  | evil-delete |
    | 3dtk | evil-delete |
    | 3dfk | evil-delete |
    | 3dtt | evil-delete |
    | 3dff | evil-delete |
    | 3dd  | evil-delete |

  Scenario: Record commands to work with surrounding delimiters
    Given I have one cursor at "inner" in "[external (outer (inner (center))]"
    And The cursors are frozen
    Then These examples with undo should pass:
    | keys | command     |
    | csbB | evil-change |
    | cs[B | evil-change |
    | csb{ | evil-change |
    | dsb  | evil-delete |
    | ds(  | evil-delete |
    | cib  | evil-change |
    | yib  | evil-yank   |

  Scenario: Record commands to select inside parentheses
    Given I have one cursor at "inner" in "[external (outer (inner (center))]"
    When I press "vib"
    Then The recorded command name should be "evil-inner-paren"
    And The recorded command keys should be "ib"

  Scenario: Record the command to join two lines
    Given I have one cursor at "line" in "First line.\nSecond line."
    When I press "J"
    Then The recorded command name should be "evil-join"
    And The recorded command keys should be "J"