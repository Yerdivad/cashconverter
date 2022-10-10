<?php

namespace App\Category\Application;

use App\Category\Domain\Category;
use App\Category\Domain\CategoryRepository;

class CategoryService
{
    private CategoryRepository $repository;

    public function __construct(CategoryRepository $categoryRepository)
    {
        $this->repository = $categoryRepository;
    }

    public function getCategory(int $id):Category
    {
        return $this->repository->find($id);
    }

    public function getCategoryList(): array
    {
        $categories = $this->repository->findAll();

        $categoryList = [];
        foreach($categories as $category){
            $categoryList['categories'][$category->getName()]['id'] = $category->getId() ;
        }
        return $categoryList;
    }

}