<?php

namespace App\Attributes\Domain;

use App\Attributes\Domain\Repository\AttributesRepository;
use App\Category\Domain\Category;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: AttributesRepository::class)]
class Attributes
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $description = null;

    #[ORM\Column]
    private ?int $order_priority = null;

    #[ORM\ManyToMany(targetEntity: category::class, inversedBy: 'attributes')]
    private Collection $category_id;

    #[ORM\Column]
    private ?bool $required = null;

    #[ORM\Column(length: 255)]
    private ?string $input_type = null;

    #[ORM\OneToMany(mappedBy: 'attribute_id', targetEntity: AttributeValue::class)]
    private Collection $attributeValues;

    public function __construct()
    {
        $this->category_id = new ArrayCollection();
        $this->attributeValues = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function setDescription(string $description): self
    {
        $this->description = $description;

        return $this;
    }

    public function getOrderPriority(): ?int
    {
        return $this->order_priority;
    }

    public function setOrderPriority(int $order_priority): self
    {
        $this->order_priority = $order_priority;

        return $this;
    }

    /**
     * @return Collection<int, category>
     */
    public function getCategoryId(): Collection
    {
        return $this->category_id;
    }

    public function addCategoryId(category $categoryId): self
    {
        if (!$this->category_id->contains($categoryId)) {
            $this->category_id->add($categoryId);
        }

        return $this;
    }

    public function removeCategoryId(category $categoryId): self
    {
        $this->category_id->removeElement($categoryId);

        return $this;
    }

    public function isRequired(): ?bool
    {
        return $this->required;
    }

    public function setRequired(bool $required): self
    {
        $this->required = $required;

        return $this;
    }

    public function getInputType(): ?string
    {
        return $this->input_type;
    }

    public function setInputType(string $input_type): self
    {
        $this->input_type = $input_type;

        return $this;
    }

    /**
     * @return Collection<int, AttributeValue>
     */
    public function getAttributeValues(): Collection
    {
        return $this->attributeValues;
    }

    public function addAttributeValue(AttributeValue $attributeValue): self
    {
        if (!$this->attributeValues->contains($attributeValue)) {
            $this->attributeValues->add($attributeValue);
            $attributeValue->setAttributeId($this);
        }

        return $this;
    }

    public function removeAttributeValue(AttributeValue $attributeValue): self
    {
        if ($this->attributeValues->removeElement($attributeValue)) {
            // set the owning side to null (unless already changed)
            if ($attributeValue->getAttributeId() === $this) {
                $attributeValue->setAttributeId(null);
            }
        }

        return $this;
    }

    public function getProcessedOptions(int $categoryId): array
    {
        $processedOptions = [];
        foreach ($this->getAttributeValues()->getValues() as $attributeValue){
            if ($attributeValue->getCategory()->getId() !== $categoryId){
                continue;
            }
            $processedOptions[] = [
                'id' => $attributeValue->getId(),
                'name' => $attributeValue->getName(),
                'dependents' => $attributeValue->getDependentsValues()
            ];
        }
        return $processedOptions;
    }
}
