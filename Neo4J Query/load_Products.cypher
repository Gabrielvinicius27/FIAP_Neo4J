LOAD CSV WITH HEADERS FROM 'file:///Product.csv' as file
WITH file WHERE file._id IS NOT NULL
MERGE (:Products {_id:file._id, code:file.code, description:file.description, name:file.name,
_colourgroup:file._ColourGroup, _graphicalappearance:file._GraphicalAppearance, _garmentgroup:file._GarmentGroup,
_perceivedcolourvalue:file._PerceivedColourValue, _perceivedcolourmaster:file._PerceivedColourMaster, 
_department:file._Department, _index:file._Index, _producttype:file._ProductType});