Type songFading_type

  pulse As Double
  pulseLength As Double
  
  travelled As Integer



End Type




Type main_char_type

  action As Integer
  action_lock As Integer

  attacking As Integer
  b_key As Integer                     
  crazy_points As Integer
  crazy_cache As Integer
  crazy_dcache As Integer
    
  has_bar As Integer 
  has_item As Integer
  hasItem( 5 ) as integer
  
  
  has_weapon As Integer
  

  powder As Integer

  selected_item As Integer

  weapon As Integer 

  invisibleEntry As Integer
  
  hasCostume( 8 ) As Byte
  isWearing As Integer
  
  fadeStyle As Integer
  
  isLoading As Integer
  
  dropoutSequence As Integer
  
  quakeViolence As Integer

  songFade As songFading_type Ptr
  
  healTimer as double
  
  specialSequence as sequence_type ptr
  
  adrenaline as double

  healing as integer
  healingFrame as integer
  healingImage as LLSystem_ImageHeader ptr
  
  roomVisited as byte ptr
  
  healthdummy( 3 ) as integer
  maxhealthdummy( 3 ) as integer
  weapondummy( 3 ) as integer
  itemdummy  ( 5, 3 ) as integer
  outfitdummy( 5, 3 ) as integer
  moneydummy ( 3 ) as integer
  
  randomizer as integer
  randomizer2 as integer
  
  randomized as integer
    
End Type


