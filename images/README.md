# Images Directory

This directory contains images used in the LuxeStay Hotel Reservation System.

## Required Images

The application uses high-quality hotel images from Unsplash. The images are referenced in the database schema and frontend code.

### Hotel Images
- `hotel1.jpg` - Grand Palace Hotel
- `hotel2.jpg` - Ocean View Resort
- `hotel3.jpg` - Mountain Lodge
- `hotel4.jpg` - City Center Boutique
- `hotel5.jpg` - Desert Oasis Spa

### How to Add Images

1. Download high-quality hotel images from Unsplash or similar free stock photo sites
2. Resize images to approximately 800x600 pixels for optimal performance
3. Save images in this directory with the appropriate names
4. Update the database schema (`database/schema.sql`) with the correct image URLs if needed

### Alternative: Using External URLs

The current implementation uses external URLs from Unsplash in the database schema. This works well for development and demo purposes.

For production, consider:
- Hosting images on a CDN
- Using a cloud storage service (AWS S3, Google Cloud Storage, etc.)
- Implementing image upload functionality

## Image Specifications

- **Format**: JPG, PNG, WebP
- **Resolution**: 800x600px minimum, 1920x1080px recommended
- **File Size**: Under 500KB per image for web optimization
- **Aspect Ratio**: 4:3 or 16:9 recommended

## Credits

Images in the demo are sourced from:
- [Unsplash](https://unsplash.com) - Free stock photos
- Photo credits are included in the database schema comments