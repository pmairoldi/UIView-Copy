# UIView+Copy CHANGELOG

## 0.0.1

Initial release.

## 0.0.5

Fixes issue where drawRect drawing doesn't happen. The issue still persists if needsDrawRect is set to NO

## 0.0.6

Fixed highlight property crash

## 0.0.7

Added copy view from snapshot api. Moved methods to other file to prevent method clash in UIView. Renamed things to fix analyzer warnings.

## 0.0.8

Added class prefix to pervent category clashes