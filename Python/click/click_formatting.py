import click

@click.command()
@click.option("-i", "--input_file", default=None, help="input file in excel format")
@click.option("-o", "--output_file", default=None, help="output file in excel format")

def main(input_file, output_file):
	""" Explanation of the function
	
	Args:
		input_file (file):
		output_file (file):
		
	Returns:
		None
	"""
	
	
if __name__ == "__main__":
	main()