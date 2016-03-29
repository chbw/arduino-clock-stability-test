## Copyright (C) 2016 
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} analyzeppmdata (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author:  Christoph B. Wurzinger
## Created: 2016-03-29

clc;
clear all;

data = load("log-endtime-2016-03-29T1126+0200");
%data = data(end/2:end);
%data = data(10000:end);
data_raw = data;

N = length(data);
t = 1:length(data);
n = 0:N-1;
f = n/N;

% replace outliers with approximation
all_idx = 1:length(data);
outlier_idx = find(abs(data)>0.008e6); % missed at least one pulse
non_outlier_idx = setdiff(all_idx, outlier_idx);
%data(outlier_idx) = interp1(non_outlier_idx, data(non_outlier_idx), outlier_idx);
data = medfilt1(data_raw,37);

missing_seconds = -sum(data_raw(outlier_idx))/1e6

error_mean = mean(data);
error_std = std(data);


figure(2);clf;
title("GPS PPS error in micros as measured by an arduino (i.e. the arduino's error)");

subplot(2,1,1);hold all;
plot(t,data);
plot(t(outlier_idx),data(outlier_idx),'rx');
grid on;box on;
title("error vs. time");
xlabel("time (s)");
ylabel("error (µs or pppm)");
legend(sprintf("mean: %.3f, std: %.3f", error_mean, error_std));

subplot(2,1,2);hold all;
plot(t(outlier_idx),data_raw(outlier_idx)/1e6,'rx');
grid on;box on;
title("outliers vs. time");
xlabel("time (s)");
ylabel("error (s)");



figure(1);clf;hold all;
periodogram(data, rectwin(length(data)), length(data), 1);
set(gca,'xscale','log');
grid on; box on;

