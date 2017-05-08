# Read Me

## Usage
##### Place in experiment.sh Matching software directory
##### Requires Matlab/bin to be in the PATH.
##### Run: ./experiment.sh arg1 arg2

### Arguments:
###### arg1: crf value to start at
###### arg2: codec to use e.g. libx264

### Required Folder structure:

			Matching Software
					  |
				experiments
					  |
				  images
				 /      \
	 original      output
			 | 	         |
	 png images	   output_folders
							     |
						     output images

* output_folders: one folders per experiment (codec, crf and group of pictures values) e.g. libx264_crf23_gpofpic:24.
* output and output_folders are created when not present and files inside the folders are overwritten.
*  original: contains original images named in ascending order (0001,0002,0003,...)
* Each output_folder contains images numbered in the same way as the input images (required by the matlab program in order to do the matching)
* images are encoded and decoded by ffmpeg using the specified settings. Resulting images
are placed in the respecive output_folder.
Then Matlab is used to do the matching (matches each folder against the original images)
* Results values are appended to the file experiment/images/results.txt.
Format: original_folder output_folder EER-score

### Progress and Problems
* ffmpeg part works correctly
* the matlab program somehow requests more arguments and does hence not work. Works perfectly
	in Windows using the same arguments. Weird!
