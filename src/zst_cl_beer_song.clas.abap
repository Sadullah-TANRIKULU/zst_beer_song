CLASS zst_cl_beer_song DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS recite
      IMPORTING
        VALUE(initial_bottles_count) TYPE i
        !take_down_count             TYPE i
      RETURNING
        VALUE(result)                TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zst_cl_beer_song IMPLEMENTATION.
  METHOD recite.

*    result = VALUE string_table(
*      FOR i = 0 UNTIL i = take_down_count
*      (
*         COND string(
*         LET take_current_count = initial_bottles_count - i
*             take_new_count = take_current_count - 1
*          IN
*          WHEN take_current_count = 1 THEN |{ take_current_count } bottle of beer on the wall, { take_current_count } bottle of beer.|
*          WHEN take_new_count <= 0 THEN |No more bottles of beer on the wall, no more bottles of beer.|
*          ELSE  |{ take_current_count } bottles of beer on the wall, { take_current_count } bottles of beer.|
*          )
*      )
*      (
*         COND string(
*         LET current_count = initial_bottles_count - i
*             new_count = current_count - 1
*          IN
*          WHEN current_count = 2 THEN |Take one down and pass it around, 1 bottle of beer on the wall.|
*          WHEN current_count = 1 THEN |Take it down and pass it around, no more bottles of beer on the wall.|
*          WHEN new_count <= 0 THEN |Go to the store and buy some more, 99 bottles of beer on the wall.|
*          ELSE |Take one down and pass it around, { new_count } bottles of beer on the wall.|
*          )
*      )
*      ( ||
*      )
*    ).
*    DELETE result INDEX lines( result ).

    " alternative solution
    result = VALUE #( FOR lv_bottles = initial_bottles_count THEN lv_bottles - 1 UNTIL lv_bottles = initial_bottles_count - take_down_count
                          ( |{ COND #( WHEN lv_bottles = 0 THEN |No more| ELSE |{ lv_bottles }| ) } | &&
                            |{ COND #( WHEN lv_bottles = 1 THEN |bottle| ELSE |bottles| ) } of beer on the wall, | &&
                            |{ COND #( WHEN lv_bottles = 0 THEN |no more| ELSE |{ lv_bottles }| ) } | &&
                            |{ COND #( WHEN lv_bottles = 1 THEN |bottle| ELSE |bottles| ) } of beer.| )
                          ( |{ COND #( WHEN lv_bottles <> 0 THEN
                               |Take { COND #( WHEN lv_bottles = 1 THEN |it| ELSE |one| ) } down and pass it around, | &&
                               |{ COND #( WHEN lv_bottles - 1 = 0 THEN |no more| ELSE |{ lv_bottles - 1 }| ) } | &&
                               |{ COND #( WHEN lv_bottles - 1 = 1 THEN |bottle| ELSE |bottles| ) } of beer on the wall.|
                               ELSE |Go to the store and buy some more, 99 bottles of beer on the wall.| ) }| )
                          ( || )
                        ).
    DELETE result INDEX lines( result ).
  ENDMETHOD.
ENDCLASS.
