# Read Me

## experiments.sh
### Usage
##### Create folder structure
##### Run: ./experiment.sh arg1 arg2 arg3

### Arguments:
###### arg1: crf value to start at3
###### arg2: crf value to stop at
###### arg3: codec to use e.g. libx264

### Folder structure:

			  some folder
				|
			  experiments
	     		        |
			     images
		            /      \
	              original      output
			 | 	      |
	 	      png images    output_folders
				      |
				    output images

* some folder: place experiments.sh here
* output_folders: one folders per experiment (codec-crf-groupOfPics-vidSize) e.g. libx264-23-24-1293.
* output and output_folders are created when not present and files inside the folders are overwritten.
* original: contains original images.
* Each output_folder contains images numbered in the same way as the input images (required by the matlab program in order to do the matching)
* images are encoded and decoded by ffmpeg using the specified settings. Resulting images
	are placed in the respecive output_folder.

## matching.cmd
### Usage
##### Place matching.sh in Matching Software folder
##### Create folder structure
##### Requires Matlab/bin to be in the PATH.

### Required Folder structure:

			Matching Software
				|
			  experiments
	     		        |
			     images
		            /      \
	              original      output
			 | 	      |
	 	      png images    output_folders
				      |
				    output images

* Results values are appended to the file experiment/images/results.txt.
  Format: output_folder: EER score
  output_folder: codec-crf-groupOfPics-vidSize

## jp2_compression.sh
### Usage
##### Place jp2_compression.sh in image folder
##### Create folder structure
##### bash jp2_compression.sh

### Folder structure:

			  some folder
				|
			  experiments
	     		        |
			     images
		            /      \
	              original      output
			 | 	      |
	 	      png images    output_folders
				      |
				    output images

* Results are placed in an output_folder (named: jp2-"rate"-"size", size currently in Bytes: du -b)
* All original images get compressed and are stored in one single folder
* TODO: find suitable "compression rates" (actually the used parameter is not a "real" ratio, it seems to be the number of compression runs with standard settings)
* List of "compression rates" and corresponding folder sizes (in bytes):
  - 2:134410227
  - 3:120568007
  - 4:91642589
  - 10:36621966
  - 20:18228945
  - 30:12094183
  - 40:9068498
  - 50:7266708
  - 60:6050048
  - 70:5194201
  - 80:4563487
  - 90:4073236
  - 100:3672918

### Progress and Problems
* ffmpeg part works correctly
* matlab problem persists. Somehow the path is not recognized by matlab using linux. Still weird!
  Solved by only doing the ffmpeg part in linux. Do matching in windows:
  Create same structure in windows and use matching.cmd.
	Move matching.cmd to Matching Software folder and execute
