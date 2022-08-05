nodes = ['ColourGroup', 'GraphicalAppearance', 'GarmentGroup', 'PerceivedColourValue', 'PerceivedColourMaster', 'Index', 'ProductType']
temp = ""
for node in nodes:
    temp = temp + f"--relationships import/products_{node}_relationship.csv "
print(temp)