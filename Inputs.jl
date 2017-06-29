# ----------------------------------------------------------------------------------- #
# Copyright (c) 2017 Varnerlab
# Robert Frederick Smith School of Chemical and Biomolecular Engineering
# Cornell University, Ithaca NY 14850
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# ----------------------------------------------------------------------------------- #
#
# ----------------------------------------------------------------------------------- #
# Function: calculate_input_array
# Description: Calculate the simulation inputs at time t
# Generated on: 2017-05-13T16:23:19.136
#
# Input arguments:
# t::Float64 => Current time value (scalar)
# x::Array{Float64,1} => State array (number_of_species x 1)
# data_dictionary::Dict{AbstractString,Any} => Dictionary holding model parameters
#
# Output arguments:
# u::Array{Float64,1} => Input array (number_of_species x 1) at time t
# ----------------------------------------------------------------------------------- #
function calculate_input_array(t::Float64,x::Array{Float64,1},data_dictionary::Dict{AbstractString,Any})

	# Initialize default -
	u_array = zeros(length(x))

	# if trigger is present, then cRAF will begin to accumulate
	tmp = max(x[55],x[56]) # the maximum of trigger RA and Trigger D3
	alpha = 1
	if x[55] > 0 && x[56] > 0
		alpha = 2
	end
	if tmp > 0 # if trigger is present
		n = 5.8
		ksat = 14
		# hill equation to discribe scaled cRAF S621 as a function of take -- taken from signal init module simulation
		# craf ~ t^n/(ksat + t^n)
		# below is the derivative of the hill equation with the given parameters
		u_array[57] = alpha*2.57615E7*t^4.8/(t^5.8 + 4.44163E6)^2#(t+delta_t)^n/(ksat^n + (t+delta_t)^n) - (t).^n/(ksat^n + t.^n)
	end
	# return -
	return u_array
end
