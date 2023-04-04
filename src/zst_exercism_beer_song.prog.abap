*&---------------------------------------------------------------------*
*& Report zst_exercism_beer_song
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zst_exercism_beer_song.


START-OF-SELECTION.

  DATA(temp_cl) = NEW zst_cl_beer_song( ).

  DATA(recite_lyrics) = temp_cl->recite(
                          initial_bottles_count = 2
                          take_down_count       = 3
                        ).

  BREAK-POINT.
