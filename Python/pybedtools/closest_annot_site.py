from pybedtools import BedTool

# Getting the closest annotation


#! bedtools closest -a bedfile -b annotation_file -D ref -t last > output_file
sites_bed = BedTool(bedfile)
annotation_bed = BedTool(annotation_file)
closest = sites_bed.closest(annotation_bed, D = "b", output = output_file)