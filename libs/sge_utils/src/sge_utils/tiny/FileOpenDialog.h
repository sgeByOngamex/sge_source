#pragma once

#include "sge_utils/sge_utils.h"
#include <string>

namespace sge {

bool DialogYesNo(const char* caption, const char* message);

std::string FileOpenDialog(const std::string& prompt, bool fileMustExists, const char* fileFilter);
std::string FileSaveDialog(const std::string& prompt, const char* fileFilter, const char* defaultExtension);
std::string FolderOpenDialog(const char* const prompt, const std::string& initialPath);

} // namespace sge
