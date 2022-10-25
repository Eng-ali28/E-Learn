/*
  Warnings:

  - You are about to drop the `student` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[categoryId]` on the table `Lesson` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[lessonId]` on the table `Quiz` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[lessonId]` on the table `Result` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `categoryId` to the `Lesson` table without a default value. This is not possible if the table is not empty.
  - Added the required column `content` to the `Lesson` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Lesson` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `LessonCategory` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lessonId` to the `LessonPdf` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pdfFile` to the `LessonPdf` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lessonId` to the `LessonVideo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `videoFile` to the `LessonVideo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `correctAns` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstAns` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `fourthAns` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lessonId` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `question` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `secondAns` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `thirdAns` to the `Quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lessonId` to the `Result` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `lesson` ADD COLUMN `categoryId` VARCHAR(191) NOT NULL,
    ADD COLUMN `content` VARCHAR(191) NOT NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `lessoncategory` ADD COLUMN `description` VARCHAR(191) NULL,
    ADD COLUMN `name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `lessonpdf` ADD COLUMN `lessonId` VARCHAR(191) NOT NULL,
    ADD COLUMN `pdfFile` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `lessonvideo` ADD COLUMN `lessonId` VARCHAR(191) NOT NULL,
    ADD COLUMN `videoFile` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `quiz` ADD COLUMN `correctAns` VARCHAR(191) NOT NULL,
    ADD COLUMN `firstAns` VARCHAR(191) NOT NULL,
    ADD COLUMN `fourthAns` VARCHAR(191) NOT NULL,
    ADD COLUMN `lessonId` VARCHAR(191) NOT NULL,
    ADD COLUMN `question` VARCHAR(191) NOT NULL,
    ADD COLUMN `secondAns` VARCHAR(191) NOT NULL,
    ADD COLUMN `thirdAns` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `result` ADD COLUMN `Score` DOUBLE NOT NULL DEFAULT 0.0,
    ADD COLUMN `TotalItem` INTEGER NULL,
    ADD COLUMN `dateRecord` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `lessonId` VARCHAR(191) NOT NULL,
    ADD COLUMN `userId` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `student`;

-- CreateTable
CREATE TABLE `User` (
    `id` VARCHAR(191) NOT NULL,
    `role` ENUM('Student', 'Teacher') NOT NULL DEFAULT 'Student',

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Profile` (
    `id` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `firstname` VARCHAR(191) NOT NULL,
    `lastname` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `birthdate` DATETIME(3) NOT NULL,
    `Address` VARCHAR(191) NOT NULL,
    `image` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Profile_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_LessonToUser` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_LessonToUser_AB_unique`(`A`, `B`),
    INDEX `_LessonToUser_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Lesson_categoryId_key` ON `Lesson`(`categoryId`);

-- CreateIndex
CREATE UNIQUE INDEX `Quiz_lessonId_key` ON `Quiz`(`lessonId`);

-- CreateIndex
CREATE UNIQUE INDEX `Result_lessonId_key` ON `Result`(`lessonId`);

-- AddForeignKey
ALTER TABLE `Profile` ADD CONSTRAINT `Profile_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Result` ADD CONSTRAINT `Result_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Result` ADD CONSTRAINT `Result_lessonId_fkey` FOREIGN KEY (`lessonId`) REFERENCES `Lesson`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Lesson` ADD CONSTRAINT `Lesson_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `LessonCategory`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Quiz` ADD CONSTRAINT `Quiz_lessonId_fkey` FOREIGN KEY (`lessonId`) REFERENCES `Lesson`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LessonVideo` ADD CONSTRAINT `LessonVideo_lessonId_fkey` FOREIGN KEY (`lessonId`) REFERENCES `Lesson`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LessonPdf` ADD CONSTRAINT `LessonPdf_lessonId_fkey` FOREIGN KEY (`lessonId`) REFERENCES `Lesson`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_LessonToUser` ADD CONSTRAINT `_LessonToUser_A_fkey` FOREIGN KEY (`A`) REFERENCES `Lesson`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_LessonToUser` ADD CONSTRAINT `_LessonToUser_B_fkey` FOREIGN KEY (`B`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
